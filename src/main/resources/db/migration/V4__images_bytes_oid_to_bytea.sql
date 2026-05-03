-- Hibernate @Lob on byte[] used PostgreSQL OID; reading LOBs failed outside a txn.
-- Convert existing OID column to bytea (no-op if already bytea or table missing).
DO
$$
    DECLARE
        typ text;
    BEGIN
        IF to_regclass('public.images') IS NULL THEN
            RETURN;
        END IF;

        SELECT format_type(a.atttypid, a.atttypmod)
        INTO typ
        FROM pg_attribute a
                 JOIN pg_class c ON c.oid = a.attrelid
                 JOIN pg_namespace n ON n.oid = c.relnamespace
        WHERE n.nspname = 'public'
          AND c.relname = 'images'
          AND a.attname = 'bytes'
          AND NOT a.attisdropped;

        IF typ = 'oid' THEN
            ALTER TABLE images
                ALTER COLUMN bytes TYPE bytea USING lo_get(bytes);
        END IF;
    END
$$;
