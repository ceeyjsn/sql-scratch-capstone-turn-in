/*** Codeflix Churn Project ***/

/* TASK 1 */
/* Getting familiar with Codeflix*/

SELECT *
FROM subscriptions
limit 100;

/* Task 2 */

SELECT MIN(subscription_start) AS 'first_sub',
   MAX(subscription_start) AS 'last_sub'
FROM subscriptions;

/* Segments */
/* Determining the number of unique segments we are looking at */

SELECT DISTINCT segment
FROM subscriptions;

/* TASK 3 */

WITH months AS (
  SELECT
    '2017-01-01' AS first_day,
    '2017-01-31' AS last_day
  UNION
  SELECT
    '2017-02-01' AS first_day,
    '2017-02-28' AS last_day
  UNION
  SELECT
    '2017-03-01' AS first_day,
    '2017-03-31' AS last_day)
SELECT *
FROM months;

/* Task 4 */

WITH months AS (
  SELECT
    '2017-01-01' AS first_day,
    '2017-01-31' AS last_day
  UNION
  SELECT
    '2017-02-01' AS first_day,
    '2017-02-28' AS last_day
  UNION
  SELECT
    '2017-03-01' AS first_day,
    '2017-03-31' AS last_day ),
cross_join AS (
  SELECT *
  FROM subscriptions
  CROSS JOIN months)
SELECT *
FROM cross_join
LIMIT 100;

/* TASK 5 */

WITH months AS (
  SELECT
    '2017-01-01' AS first_day,
    '2017-01-31' AS last_day
  UNION
  SELECT
    '2017-02-01' AS first_day,
    '2017-02-28' AS last_day
  UNION
  SELECT
    '2017-03-01' AS first_day,
    '2017-03-31' AS last_day ),
cross_join AS (
  SELECT *
  FROM subscriptions
  CROSS JOIN months),
status AS (
  SELECT cross_join.id as id,
    cross_join.first_day as 'month',
    CASE
      WHEN
        (subscription_start < first_day)
      AND
        (subscription_end > first_day
        OR
        subscription_end IS NULL)
      AND
        (segment = '87')
      THEN 1
      ELSE 0
      END AS is_active_87,
    CASE
      WHEN
        (subscription_start < first_day)
      AND
        (subscription_end > first_day
        OR
        subscription_end IS NULL)
      AND
        (segment = '30')
      THEN 1
      ELSE 0
    END AS is_active_30
    FROM cross_join)
SELECT *
FROM status
LIMIT 100;
     

/* Task 6 */

WITH months AS (
  SELECT
    '2017-01-01' AS first_day,
    '2017-01-31' AS last_day
  UNION
  SELECT
    '2017-02-01' AS first_day,
    '2017-02-28' AS last_day
  UNION
  SELECT
    '2017-03-01' AS first_day,
    '2017-03-31' AS last_day ),
cross_join AS (
  SELECT *
  FROM subscriptions
  CROSS JOIN months),
status AS (
  SELECT cross_join.id as id,
    cross_join.first_day as 'month',
    CASE
      WHEN
        (subscription_start < first_day)
      AND
        (subscription_end > first_day
        OR
        subscription_end IS NULL)
      AND
        (segment = '87')
      THEN 1
      ELSE 0
      END AS is_active_87,
    CASE
      WHEN
        (subscription_start < first_day)
      AND
        (subscription_end > first_day
        OR
        subscription_end IS NULL)
      AND
        (segment = '30')
      THEN 1
      ELSE 0
      END AS is_active_30,
    CASE
      WHEN
        (subscription_end BETWEEN first_day AND last_day)
      AND
        (segment = '87')
      THEN 1
      ELSE 0
      END AS is_canceled_87,
    CASE
      WHEN
        (subscription_end BETWEEN first_day AND last_day)
      AND
        (segment = '30')
      THEN 1
      ELSE 0
      END AS is_canceled_30
    FROM cross_join)
SELECT *
FROM status
LIMIT 100;
     

/* Task 7 */

WITH months AS (
  SELECT
    '2017-01-01' AS first_day,
    '2017-01-31' AS last_day
  UNION
  SELECT
    '2017-02-01' AS first_day,
    '2017-02-28' AS last_day
  UNION
  SELECT
    '2017-03-01' AS first_day,
    '2017-03-31' AS last_day ),
cross_join AS (
  SELECT *
  FROM subscriptions
  CROSS JOIN months),
status AS (
  SELECT cross_join.id as id,
    cross_join.first_day as 'month',
    CASE
      WHEN
        (subscription_start < first_day)
      AND
        (subscription_end > first_day
        OR
        subscription_end IS NULL)
      AND
        (segment = '87')
      THEN 1
      ELSE 0
      END AS is_active_87,
    CASE
      WHEN
        (subscription_start < first_day)
      AND
        (subscription_end > first_day
        OR
        subscription_end IS NULL)
      AND
        (segment = '30')
      THEN 1
      ELSE 0
      END AS is_active_30,
    CASE
      WHEN
        (subscription_end BETWEEN first_day AND last_day)
      AND
        (segment = '87')
      THEN 1
      ELSE 0
      END AS is_canceled_87,
    CASE
      WHEN
        (subscription_end BETWEEN first_day AND last_day)
      AND
        (segment = '30')
      THEN 1
      ELSE 0
      END AS is_canceled_30
    FROM cross_join),
status_aggregate AS (
  SELECT month,
    sum(is_active_87) as 'sum_active_87',
    sum(is_active_30) as 'sum_active_30',
    sum(is_canceled_87) as 'sum_canceled_87',
    sum(is_canceled_30) as 'sum_canceled_30'
  FROM status
  GROUP BY month)
  select *
  from status_aggregate;
     

/* TASK 8 */
WITH months AS (
  SELECT
    '2017-01-01' AS first_day,
    '2017-01-31' AS last_day
  UNION
  SELECT
    '2017-02-01' AS first_day,
    '2017-02-28' AS last_day
  UNION
  SELECT
    '2017-03-01' AS first_day,
    '2017-03-31' AS last_day ),
cross_join AS (
  SELECT *
  FROM subscriptions
  CROSS JOIN months),
status AS (
  SELECT cross_join.id as id,
    cross_join.first_day as 'month',
    CASE
      WHEN
        (subscription_start < first_day)
      AND
        (subscription_end > first_day
        OR
        subscription_end IS NULL)
      AND
        (segment = '87')
      THEN 1
      ELSE 0
      END AS is_active_87,
    CASE
      WHEN
        (subscription_start < first_day)
      AND
        (subscription_end > first_day
        OR
        subscription_end IS NULL)
      AND
        (segment = '30')
      THEN 1
      ELSE 0
      END AS is_active_30,
    CASE
      WHEN
        (subscription_end BETWEEN first_day AND last_day)
      AND
        (segment = '87')
      THEN 1
      ELSE 0
      END AS is_canceled_87,
    CASE
      WHEN
        (subscription_end BETWEEN first_day AND last_day)
      AND
        (segment = '30')
      THEN 1
      ELSE 0
      END AS is_canceled_30
    FROM cross_join),
status_aggregate AS (
  SELECT month,
    sum(is_active_87) as 'active_87',
    sum(is_active_30) as 'active_30',
    sum(is_canceled_87) as 'canceled_87',
    sum(is_canceled_30) as 'canceled_30'
  FROM status
  GROUP BY month)
SELECT
  month,
  1.0 * canceled_87/active_87 AS '87_churn_rate',
  1.0 * canceled_30/active_30 AS '30_churn_rate'
FROM status_aggregate;

/* Segment distribution */
/* Just to confirm if the users are evenly distributed between both segments. */

SELECT COUNT(*) AS 'total_subs'
FROM subscriptions;

SELECT COUNT(*) AS 'segment_87_subs'
FROM subscriptions
WHERE segment = 87;

SELECT COUNT(*) AS 'segment_30_subs'
FROM subscriptions
WHERE segment=30;