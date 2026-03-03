CREATE OR REPLACE VIEW mart_production_monthly AS
SELECT
    DATE_TRUNC('month', date) AS year_month,
    EXTRACT(YEAR FROM date) AS year,
    EXTRACT(MONTH FROM date) AS month,

    plant,
    line_id,
    beer_id,
    shift,

    -- agregacje wolumenowe
    SUM(planned_volume_l) AS planned_volume_l,
    SUM(produced_volume_l) AS produced_volume_l,
    SUM(waste_l) AS waste_l,

    -- agregacje czasowe
    SUM(runtime_min) AS runtime_min,
    SUM(planned_runtime_min) AS planned_runtime_min,
    SUM(downtime_min) AS downtime_min,

    -- koszty
    SUM(batch_cost) AS total_batch_cost,

    -- dodatkowe
    COUNT(DISTINCT batch_id) AS batch_count

FROM main.fact_production
GROUP BY
    DATE_TRUNC('month', date),
    EXTRACT(YEAR FROM date),
    EXTRACT(MONTH FROM date),
    plant,
    line_id,
    beer_id,
    shift;