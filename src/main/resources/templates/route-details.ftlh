<!DOCTYPE html>
<html lang="ru">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Blizzard Trans — Детали маршрута</title>
    <link rel="stylesheet" href="/css/base.css">
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="https://unpkg.com/leaflet@1.9.4/dist/leaflet.css"/>
    <style>
        * {
            margin: 0;
            padding: 0;
            box-sizing: border-box;
        }

        body {
            font-family: 'Inter', -apple-system, BlinkMacSystemFont, 'Segoe UI', sans-serif;
            background: linear-gradient(135deg, #f8fafc 0%, #f1f5f9 100%);
            color: #0f172a;
            line-height: 1.5;
            min-height: 100vh;
            padding: 24px;
        }

        .container {
            max-width: 900px;
            margin: 0 auto;
        }

        /* Карточка */
        .card {
            background: white;
            border-radius: 32px;
            box-shadow: 0 20px 35px -12px rgba(0, 0, 0, 0.1);
            overflow: hidden;
            border: 1px solid rgba(0, 0, 0, 0.05);
        }

        /* Шапка карточки */
        .card-header {
            background: linear-gradient(135deg, #1e293b 0%, #0f172a 100%);
            padding: 32px 32px 28px;
            color: white;
            position: relative;
        }

        .card-header h1 {
            font-size: 28px;
            font-weight: 700;
            margin-bottom: 12px;
            letter-spacing: -0.3px;
        }

        .route-path {
            display: flex;
            align-items: center;
            gap: 12px;
            flex-wrap: wrap;
            margin-top: 16px;
        }

        .path-point {
            background: rgba(255, 255, 255, 0.15);
            padding: 8px 20px;
            border-radius: 40px;
            font-weight: 500;
            font-size: 15px;
        }

        .path-arrow {
            font-size: 20px;
            color: #94a3b8;
        }

        /* Статус бейдж в шапке */
        .status-badge-large {
            position: absolute;
            top: 32px;
            right: 32px;
            padding: 8px 20px;
            border-radius: 40px;
            font-weight: 600;
            font-size: 14px;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .status-active {
            background: #22c55e;
            color: white;
        }

        .status-in-process {
            background: #f59e0b;
            color: white;
        }

        .status-completed {
            background: #64748b;
            color: white;
        }

        /* Основной контент */
        .card-content {
            padding: 32px;
        }

        /* Секции */
        .info-section {
            margin-bottom: 32px;
        }

        .section-title {
            font-size: 18px;
            font-weight: 600;
            color: #0f172a;
            margin-bottom: 20px;
            padding-bottom: 12px;
            border-bottom: 2px solid #eef2f6;
            display: flex;
            align-items: center;
            gap: 10px;
        }

        /* Сетка деталей */
        .details-grid {
            display: grid;
            grid-template-columns: repeat(auto-fit, minmax(280px, 1fr));
            gap: 20px;
        }

        .detail-item {
            background: #f8fafc;
            padding: 16px 20px;
            border-radius: 20px;
            transition: all 0.2s;
        }

        .detail-item:hover {
            background: #f1f5f9;
            transform: translateY(-2px);
        }

        .detail-label {
            font-size: 13px;
            font-weight: 500;
            color: #64748b;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            margin-bottom: 8px;
            display: flex;
            align-items: center;
            gap: 6px;
        }

        .detail-value {
            font-size: 20px;
            font-weight: 700;
            color: #0f172a;
        }

        .detail-value-small {
            font-size: 16px;
            font-weight: 500;
        }

        /* Блок контактов */
        .contact-card {
            background: linear-gradient(135deg, #f8fafc 0%, #ffffff 100%);
            border: 1px solid #eef2f6;
            border-radius: 20px;
            padding: 20px;
            margin-top: 16px;
        }

        .contact-row {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px 0;
            border-bottom: 1px solid #eef2f6;
        }

        .contact-row:last-child {
            border-bottom: none;
        }

        .contact-icon {
            width: 40px;
            height: 40px;
            background: #eef2ff;
            border-radius: 12px;
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 20px;
        }

        .contact-info {
            flex: 1;
        }

        .contact-label {
            font-size: 12px;
            color: #64748b;
        }

        .contact-value {
            font-weight: 600;
            color: #0f172a;
        }

        /* Блок действий */
        .actions-section {
            display: flex;
            justify-content: space-between;
            gap: 16px;
            flex-wrap: wrap;
            margin-top: 32px;
            padding-top: 24px;
            border-top: 2px solid #eef2f6;
        }

        .btn {
            padding: 12px 20px;
            border-radius: 40px;
            font-weight: 600;
            font-size: 14px;
            cursor: pointer;
            transition: all 0.2s;
            border: none;
            text-decoration: none;
            display: inline-flex;
            align-items: center;
            gap: 8px;
        }

        .btn-back {
            background: #f1f5f9;
            color: #475569;
        }

        .btn-back:hover {
            background: #e2e8f0;
            transform: translateY(-2px);
        }

        .btn-danger {
            background: #ef4444;
            color: white;
        }

        .btn-danger:hover {
            background: #dc2626;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(239, 68, 68, 0.3);
        }

        .btn-success {
            background: #22c55e;
            color: white;
        }

        .btn-success:hover {
            background: #16a34a;
            transform: translateY(-2px);
            box-shadow: 0 4px 12px rgba(34, 197, 94, 0.3);
        }

        /* Примечания */
        .notes-block {
            background: #fefce8;
            border-left: 4px solid #eab308;
            padding: 16px 20px;
            border-radius: 16px;
            margin-top: 20px;
        }

        .notes-block p {
            color: #854d0e;
            margin: 0;
        }

        /* Адаптивность */
        @media (max-width: 768px) {
            body {
                padding: 16px;
            }

            .card-header {
                padding: 24px 20px;
            }

            .status-badge-large {
                position: static;
                display: inline-block;
                margin-top: 16px;
            }

            .card-content {
                padding: 24px 20px;
            }

            .details-grid {
                grid-template-columns: 1fr;
            }

            .actions-section {
                flex-direction: column;
            }

            .btn {
                justify-content: center;
            }

            .route-path {
                flex-direction: column;
                align-items: flex-start;
            }

            .path-arrow {
                transform: rotate(90deg);
                align-self: center;
            }
        }

        /* Анимация появления */
        @keyframes fadeInUp {
            from {
                opacity: 0;
                transform: translateY(20px);
            }
            to {
                opacity: 1;
                transform: translateY(0);
            }
        }

        .card {
            animation: fadeInUp 0.4s ease-out;
        }

        /* ── MAP SECTION ─────────────────────────────── */
        #routeMapContainer {
            border-radius: 20px;
            overflow: hidden;
            border: 1px solid #e2e8f0;
            position: relative;
        }

        #routeMap {
            width: 100%;
            height: 360px;
        }

        .map-route-info {
            display: flex;
            align-items: center;
            gap: 12px;
            padding: 12px 16px;
            background: #f8fafc;
            border-top: 1px solid #e2e8f0;
            font-size: 14px;
            font-weight: 500;
            color: #475569;
            flex-wrap: wrap;
        }

        .map-route-info span {
            display: inline-flex;
            align-items: center;
            gap: 5px;
        }

        .map-route-pill {
            background: #eff6ff;
            color: #2563eb;
            padding: 4px 12px;
            border-radius: 20px;
            font-size: 13px;
            font-weight: 600;
        }

        .map-loading-overlay {
            position: absolute;
            inset: 0;
            background: #f8fafc;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            gap: 10px;
            z-index: 5;
            transition: opacity .3s;
        }

        .map-loading-overlay.hidden {
            opacity: 0;
            pointer-events: none;
        }

        .map-spinner {
            width: 32px;
            height: 32px;
            border: 3px solid #e2e8f0;
            border-top-color: #3b82f6;
            border-radius: 50%;
            animation: spin .7s linear infinite;
        }

        @keyframes spin { to { transform: rotate(360deg); } }

        .map-loading-overlay p {
            font-size: 13px;
            color: #64748b;
        }

        .map-error-msg {
            padding: 12px 16px;
            background: #fef2f2;
            color: #dc2626;
            font-size: 13px;
            font-weight: 500;
            border-top: 1px solid #fecaca;
            display: none;
        }
    </style>
</head>
<body>
<div class="container">
    <div class="card">
        <!-- ШАПКА С ГРАДИЕНТОМ -->
        <div class="card-header">
            <h1>📦 Детали маршрута</h1>
            <div class="route-path">
                <span class="path-point">📍 ${route.startLocation!''}</span>
                <span class="path-arrow">→</span>
                <span class="path-point">🎯 ${route.endLocation!''}</span>
            </div>

            <!-- СТАТУС (динамический) -->
            <#if status??>
                <#if status == "Заказ создан и ожидает обработки.">
                    <div class="status-badge-large status-active">
                        ⏳ ${status}
                    </div>
                <#elseif status == "Заказ находится в процессе доставки.">
                    <div class="status-badge-large status-in-process">
                        🚚 ${status}
                    </div>
                <#else>
                    <div class="status-badge-large status-completed">
                        ✅ ${status}
                    </div>
                </#if>
            </#if>
        </div>

        <!-- ОСНОВНОЙ КОНТЕНТ -->
        <div class="card-content">
            <!-- ИНФОРМАЦИЯ О МАРШРУТЕ -->
            <div class="info-section">
                <div class="section-title">
                    <span>📋</span> Информация о перевозке
                </div>
                <div class="details-grid">
                    <div class="detail-item">
                        <div class="detail-label">📏 Расстояние</div>
                        <div class="detail-value">${route.distance!0} км</div>
                    </div>
                    <div class="detail-item">
                        <div class="detail-label">⚖️ Вес груза</div>
                        <div class="detail-value">${route.cargo_weight!0} кг</div>
                    </div>
                    <div class="detail-item">
                        <div class="detail-label">💰 Оплата</div>
                        <div class="detail-value">${route.payment!0} ₽</div>
                    </div>
                    <div class="detail-item">
                        <div class="detail-label">📅 Размещён</div>
                        <div class="detail-value-small">${route.formattedCreatedAt!''}</div>
                    </div>
                    <#if route.updatedAt??>
                        <div class="detail-item">
                            <div class="detail-label">🔄 Обновлено</div>
                            <div class="detail-value-small">${route.formattedUpdatedAt!''}</div>
                        </div>
                    </#if>
                </div>
            </div>

            <!-- КАРТА МАРШРУТА -->
            <div class="info-section">
                <div class="section-title">
                    <span>🗺️</span> Предполагаемый маршрут
                </div>
                <div id="routeMapContainer">
                    <div id="routeMap"></div>
                    <div class="map-loading-overlay" id="mapLoadingOverlay">
                        <div class="map-spinner"></div>
                        <p>Строим маршрут…</p>
                    </div>
                    <div class="map-error-msg" id="mapErrorMsg"></div>
                    <div class="map-route-info" id="mapRouteInfo" style="display:none;">
                        <span>📍 <strong>${route.startLocation!''}</strong></span>
                        <span style="color:#cbd5e1;">→</span>
                        <span>🎯 <strong>${route.endLocation!''}</strong></span>
                        <span class="map-route-pill" id="routeDistance"></span>
                        <span class="map-route-pill" id="routeDuration"></span>
                    </div>
                </div>
            </div>

            <!-- ОПИСАНИЕ ГРУЗА -->
            <div class="info-section">
                <div class="section-title">
                    <span>📦</span> Описание груза
                </div>
                <div class="detail-item" style="background: #f8fafc;">
                    <div class="detail-value-small">${route.cargo_description!'Нет описания'}</div>
                </div>
            </div>

            <!-- КОНТАКТЫ ЗАКАЗЧИКА -->
            <div class="info-section">
                <div class="section-title">
                    <span>👤</span> Контактные данные
                </div>
                <div class="contact-card">
                    <div class="contact-row">
                        <div class="contact-icon">👤</div>
                        <div class="contact-info">
                            <div class="contact-label">Заказчик</div>
                            <div class="contact-value">${route.customer.username!'Не указан'}</div>
                        </div>
                    </div>
                    <div class="contact-row">
                        <div class="contact-icon">📧</div>
                        <div class="contact-info">
                            <div class="contact-label">Email</div>
                            <div class="contact-value">${route.customer.email!'Не указан'}</div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- ПРИМЕЧАНИЯ (если есть) -->
            <#if route.order_notes?? && route.order_notes != "">
                <div class="notes-block">
                    <p>📝 <strong>Примечания к заказу:</strong> ${route.order_notes}</p>
                </div>
            </#if>

            <!-- ДЕЙСТВИЯ -->
            <div class="actions-section">
                <button onclick="javascript:history.back()" class="btn btn-back">
                    ← Вернуться назад
                </button>

                <#if user.id == route.customer.id || user.isAdmin()>
                    <form action="/delete_route/${route.id}" method="post" style="margin: 0;">
                        <input type="hidden" name="_csrf" value="${_csrf.token}">
                        <button type="submit" class="btn btn-danger">
                            🗑️ Удалить маршрут
                        </button>
                    </form>
                </#if>

                <#if (user.isCarrier() || user.isAdmin()) && status == "Заказ создан и ожидает обработки.">
                    <form action="/carrier/select_car" method="post" style="margin: 0;">
                        <input type="hidden" name="carrierId" value="${user.id}">
                        <input type="hidden" name="routeId" value="${route.id}">
                        <input type="hidden" name="_csrf" value="${_csrf.token}">
                        <button type="submit" class="btn btn-success">
                            🚚 Взять в работу
                        </button>
                    </form>
                </#if>
            </div>
        </div>
    </div>
</div>

<script src="https://unpkg.com/leaflet@1.9.4/dist/leaflet.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function() {
        const card = document.querySelector('.card');
        if (card) card.style.animation = 'fadeInUp 0.5s ease-out';
    });

    const START = '${route.startLocation!""}';
    const END   = '${route.endLocation!""}';

    function hideMapLoading() {
        const overlay = document.getElementById('mapLoadingOverlay');
        overlay.classList.add('hidden');
        setTimeout(() => overlay.style.display = 'none', 350);
    }

    function showMapError(msg) {
        hideMapLoading();
        const el = document.getElementById('mapErrorMsg');
        el.textContent = '⚠️ ' + msg;
        el.style.display = 'block';
    }

    async function geocode(address) {
        const url = 'https://nominatim.openstreetmap.org/search?q='
            + encodeURIComponent(address)
            + '&format=json&limit=1&accept-language=ru';
        const resp = await fetch(url, { headers: { 'User-Agent': 'RouteTracerApp/1.0' } });
        const data = await resp.json();
        if (!data.length) throw new Error('Адрес не найден: ' + address);
        return { lat: parseFloat(data[0].lat), lon: parseFloat(data[0].lon), display: data[0].display_name };
    }

    async function fetchOsrmRoute(startCoord, endCoord) {
        const url = 'https://router.project-osrm.org/route/v1/driving/'
            + startCoord.lon + ',' + startCoord.lat + ';'
            + endCoord.lon   + ',' + endCoord.lat
            + '?overview=full&geometries=geojson';
        const resp = await fetch(url);
        const data = await resp.json();
        if (data.code !== 'Ok' || !data.routes.length) throw new Error('OSRM: нет маршрута');
        const route = data.routes[0];
        return {
            coords:      route.geometry.coordinates.map(([lon, lat]) => [lat, lon]),
            distanceKm:  (route.distance / 1000).toFixed(1),
            durationMin: Math.round(route.duration / 60)
        };
    }

    document.addEventListener('DOMContentLoaded', async function() {
        if (!START || !END) {
            showMapError('Начальная или конечная точка маршрута не указана.');
            return;
        }

        const map = L.map('routeMap');
        L.tileLayer('https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png', {
            attribution: '© <a href="https://www.openstreetmap.org/copyright">OpenStreetMap</a>',
            maxZoom: 19
        }).addTo(map);
        map.attributionControl.setPrefix('');

        try {
            // Геокодируем оба адреса параллельно (Nominatim)
            const [startCoord, endCoord] = await Promise.all([geocode(START), geocode(END)]);

            // Маркер старта (зелёный)
            const greenIcon = new L.Icon({
                iconUrl: 'https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-green.png',
                shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.9.4/images/marker-shadow.png',
                iconSize: [25, 41], iconAnchor: [12, 41], popupAnchor: [1, -34], shadowSize: [41, 41]
            });
            // Маркер финиша (красный — стандартный Leaflet)
            const redIcon = new L.Icon({
                iconUrl: 'https://raw.githubusercontent.com/pointhi/leaflet-color-markers/master/img/marker-icon-2x-red.png',
                shadowUrl: 'https://cdnjs.cloudflare.com/ajax/libs/leaflet/1.9.4/images/marker-shadow.png',
                iconSize: [25, 41], iconAnchor: [12, 41], popupAnchor: [1, -34], shadowSize: [41, 41]
            });

            L.marker([startCoord.lat, startCoord.lon], { icon: greenIcon })
                .addTo(map).bindPopup('<b>Старт</b><br>' + START);
            L.marker([endCoord.lat, endCoord.lon], { icon: redIcon })
                .addTo(map).bindPopup('<b>Финиш</b><br>' + END);

            try {
                // Строим маршрут по дорогам (OSRM)
                const route = await fetchOsrmRoute(startCoord, endCoord);
                const polyline = L.polyline(route.coords, { color: '#3b82f6', weight: 5, opacity: 0.85 }).addTo(map);
                map.fitBounds(polyline.getBounds(), { padding: [40, 40] });

                const hours = Math.floor(route.durationMin / 60);
                const mins  = route.durationMin % 60;
                const durationText = hours > 0 ? hours + ' ч ' + mins + ' мин' : mins + ' мин';

                document.getElementById('routeDistance').textContent = '📏 ' + route.distanceKm + ' км';
                document.getElementById('routeDuration').textContent = '⏱ ' + durationText;
            } catch (osrmErr) {
                // OSRM недоступен — рисуем пунктирную прямую
                console.warn('OSRM failed, drawing straight line:', osrmErr);
                const line = L.polyline(
                    [[startCoord.lat, startCoord.lon], [endCoord.lat, endCoord.lon]],
                    { color: '#3b82f6', weight: 3, opacity: 0.7, dashArray: '8, 8' }
                ).addTo(map);
                map.fitBounds(line.getBounds(), { padding: [60, 60] });

                document.getElementById('mapErrorMsg').textContent =
                    'ℹ️ Маршрут по дорогам временно недоступен — показана прямая линия.';
                document.getElementById('mapErrorMsg').style.cssText =
                    'display:block; background:#eff6ff; color:#2563eb; border-top:1px solid #bfdbfe; padding:12px 16px; font-size:13px; font-weight:500;';
            }

            document.getElementById('mapRouteInfo').style.display = 'flex';
            hideMapLoading();

        } catch (err) {
            console.error('Map init error:', err);
            showMapError('Не удалось найти адреса на карте. ' + err.message);
        }
    });
</script>
</body>
</html>