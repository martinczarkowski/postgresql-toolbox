/*
Purpose:
  Demonstrates basic PL/pgSQL exception handling.

Notes:
  - Template only.
  - Do not swallow errors silently.
  - Use exception handling for expected cases or to add useful context.

Compatibility:
  PostgreSQL 9.6+
*/

CREATE OR REPLACE FUNCTION public.example_process_item(
    p_item_id integer
)
RETURNS void
LANGUAGE plpgsql
AS $$
BEGIN
    IF p_item_id IS NULL THEN
        RAISE EXCEPTION 'Parameter p_item_id cannot be NULL';
    END IF;

    UPDATE public.example_items
    SET processed_at = now()
    WHERE id = p_item_id;

    IF NOT FOUND THEN
        RAISE EXCEPTION 'Item with id % was not found', p_item_id;
    END IF;

EXCEPTION
    WHEN foreign_key_violation THEN
        RAISE EXCEPTION 'Cannot process item %, related data is missing or invalid', p_item_id
            USING ERRCODE = SQLSTATE;

    WHEN others THEN
        RAISE EXCEPTION 'Unexpected error while processing item %. Original error: %', p_item_id, SQLERRM
            USING ERRCODE = SQLSTATE;
END;
$$;