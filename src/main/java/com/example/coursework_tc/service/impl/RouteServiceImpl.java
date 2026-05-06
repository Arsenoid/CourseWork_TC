package com.example.coursework_tc.service.impl;

import com.example.coursework_tc.model.Route;
import com.example.coursework_tc.model.User;
import com.example.coursework_tc.repository.RouteRepository;
import com.example.coursework_tc.service.RouteService;
import com.example.coursework_tc.service.UserService;
import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;
import lombok.AllArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.io.IOException;
import java.net.URI;
import java.net.URLEncoder;
import java.net.http.HttpClient;
import java.net.http.HttpRequest;
import java.net.http.HttpResponse;
import java.nio.charset.StandardCharsets;
import java.security.Principal;
import java.util.List;

@Slf4j
@Service
@AllArgsConstructor
public class RouteServiceImpl implements RouteService {
    private static final String NOMINATIM_URL = "https://nominatim.openstreetmap.org/search?format=json&limit=1&accept-language=ru&q=";
    private static final String OSRM_URL = "https://router.project-osrm.org/route/v1/driving/";

    private final RouteRepository routeRepository;
    private final UserService userService;
    private final ObjectMapper objectMapper = new ObjectMapper();
    private final HttpClient httpClient = HttpClient.newHttpClient();

    @Override
    public List<Route> getAllRoutes() {
        return routeRepository.findAll();
    }

    @Override
    public List<Route> getAllRoutesByCustomer(User user) {
        return routeRepository.findAllByCustomerId(user.getId());
    }

    @Override
    public void addRoute(Principal principal, Route route) {
        User customer = userService.getUserByPrincipal(principal);
        route.setCustomer(customer);
        route.setDistance(resolveDistance(route.getDistance(), route.getStartLocation(), route.getEndLocation()));
        routeRepository.save(route);
        log.info("Saving new Route: {} - {}", route.getStartLocation(), route.getEndLocation());
    }

    @Override
    public Route getRouteById(Long id) {
        return routeRepository.findById(id).orElse(null);
    }

    @Override
    public void deleteRoute(Long id) {
        log.info("Deleting Route: {} - {}", routeRepository.findById(id).get().getStartLocation(), routeRepository.findById(id).get().getEndLocation());
        routeRepository.deleteById(id);
    }

    @Override
    public void editRoute(Long id, Route updatedRoute) {
        Route route = getRouteById(id);
        route.setStartLocation(updatedRoute.getStartLocation());
        route.setEndLocation(updatedRoute.getEndLocation());
        route.setDistance(resolveDistance(updatedRoute.getDistance(), updatedRoute.getStartLocation(), updatedRoute.getEndLocation()));
        route.setCargo_description(updatedRoute.getCargo_description());
        route.setCargo_weight(updatedRoute.getCargo_weight());
        route.setPayment(updatedRoute.getPayment());
        route.setOrder_notes(updatedRoute.getOrder_notes());
        routeRepository.save(route);
    }

    private Double resolveDistance(Double manualDistance, String startAddress, String endAddress) {
        if (manualDistance != null && manualDistance > 0) {
            return Math.round(manualDistance * 10.0) / 10.0;
        }
        return calculateRouteDistanceKm(startAddress, endAddress);
    }

    private Double calculateRouteDistanceKm(String startAddress, String endAddress) {
        try {
            Point start = geocodeAddress(startAddress);
            Point end = geocodeAddress(endAddress);
            return fetchDrivingDistanceKm(start, end);
        } catch (Exception e) {
            log.warn("Failed to calculate route distance for '{}' -> '{}', fallback to straight-line: {}",
                    startAddress, endAddress, e.getMessage());
            try {
                Point start = geocodeAddress(startAddress);
                Point end = geocodeAddress(endAddress);
                return haversineKm(start.lat(), start.lon(), end.lat(), end.lon());
            } catch (Exception fallbackError) {
                log.error("Failed to calculate fallback distance for '{}' -> '{}'", startAddress, endAddress, fallbackError);
                throw new IllegalStateException("Не удалось автоматически рассчитать расстояние маршрута");
            }
        }
    }

    private Point geocodeAddress(String address) throws IOException, InterruptedException {
        String url = NOMINATIM_URL + URLEncoder.encode(address, StandardCharsets.UTF_8);
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(url))
                .header("User-Agent", "RouteTracer/1.0")
                .GET()
                .build();

        HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
        JsonNode root = objectMapper.readTree(response.body());
        if (!root.isArray() || root.isEmpty()) {
            throw new IllegalStateException("Address not found: " + address);
        }
        JsonNode first = root.get(0);
        double lat = first.path("lat").asDouble();
        double lon = first.path("lon").asDouble();
        return new Point(lat, lon);
    }

    private double fetchDrivingDistanceKm(Point start, Point end) throws IOException, InterruptedException {
        String url = OSRM_URL + start.lon() + "," + start.lat() + ";" + end.lon() + "," + end.lat() + "?overview=false";
        HttpRequest request = HttpRequest.newBuilder()
                .uri(URI.create(url))
                .header("User-Agent", "RouteTracer/1.0")
                .GET()
                .build();

        HttpResponse<String> response = httpClient.send(request, HttpResponse.BodyHandlers.ofString());
        JsonNode root = objectMapper.readTree(response.body());
        JsonNode routes = root.path("routes");
        if (!routes.isArray() || routes.isEmpty()) {
            throw new IllegalStateException("No routes from OSRM");
        }
        double meters = routes.get(0).path("distance").asDouble();
        return Math.round((meters / 1000.0) * 10.0) / 10.0;
    }

    private double haversineKm(double lat1, double lon1, double lat2, double lon2) {
        final double earthRadiusKm = 6371.0;
        double dLat = Math.toRadians(lat2 - lat1);
        double dLon = Math.toRadians(lon2 - lon1);
        double a = Math.sin(dLat / 2) * Math.sin(dLat / 2)
                + Math.cos(Math.toRadians(lat1)) * Math.cos(Math.toRadians(lat2))
                * Math.sin(dLon / 2) * Math.sin(dLon / 2);
        double c = 2 * Math.atan2(Math.sqrt(a), Math.sqrt(1 - a));
        return Math.round((earthRadiusKm * c) * 10.0) / 10.0;
    }

    private record Point(double lat, double lon) {}
}
