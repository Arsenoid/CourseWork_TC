create table if not exists telemetry_points (
    id bigserial primary key,
    vehicle_id bigint not null,
    latitude double precision not null,
    longitude double precision not null,
    recorded_at timestamp not null,
    speed_kmh double precision,
    source varchar(32) not null,
    constraint fk_telemetry_vehicle
        foreign key (vehicle_id) references vehicles (id)
);

create index if not exists idx_telemetry_vehicle_recorded
    on telemetry_points (vehicle_id, recorded_at desc);

alter table vehicles
    add column if not exists last_latitude double precision;

alter table vehicles
    add column if not exists last_longitude double precision;

alter table vehicles
    add column if not exists last_telemetry_at timestamp;
