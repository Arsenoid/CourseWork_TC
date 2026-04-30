alter table telemetry_points
    alter column recorded_at type timestamptz using recorded_at at time zone 'UTC';

alter table vehicles
    alter column last_telemetry_at type timestamptz using last_telemetry_at at time zone 'UTC';
