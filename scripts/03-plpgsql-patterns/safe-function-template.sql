/*
Purpose:
  Provides a simple PL/pgSQL function template with clear parameter naming and basic validation.

Notes:
  - Template only.
  - Replace object names, parameters and logic with your own use case.
  - Keep functions small and explicit where possible.

Compatibility:
  PostgreSQL 9.6+
*/

CREATE OR REPLACE FUNCTION public.example_get_items_by_status(
    p_status integer,
    p_created_from timestamp without time zone DEFAULT NULL
)
RETURNS TABLE
(
    item_id integer,
    item_name text,
    created_at timestamp without time zone
)
LANGUAGE plpgsql
AS $$
BEGIN
    IF p_status IS NULL THEN
        RAISE EXCEPTION 'Parameter p_status cannot be NULL';
    END IF;

    RETURN QUERY
    SELECT
        i.id AS item_id,
        i.name AS item_name,
        i.created_at
    FROM public.example_items AS i
    WHERE i.status = p_status
      AND (p_created_from IS NULL OR i.created_at >= p_created_from)
    ORDER BY i.created_at DESC;
END;
$$;