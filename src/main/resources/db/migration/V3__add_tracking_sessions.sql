create table if not exists tracking_sessions (
    id          bigserial primary key,
    vehicle_id  bigint      not null,
    source      varchar(32) not null,
    status      varchar(16) not null,
    started_at  timestamptz not null,
    ended_at    timestamptz,
    constraint fk_session_vehicle foreign key (vehicle_id) references vehicles (id)
);

create index if not exists idx_sessions_vehicle
    on tracking_sessions (vehicle_id, started_at desc);

alter table telemetry_points
    add column if not exists session_id bigint,
    add constraint fk_telemetry_session
        foreign key (session_id) references tracking_sessions (id);
