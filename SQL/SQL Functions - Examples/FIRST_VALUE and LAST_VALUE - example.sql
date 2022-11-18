-------------------------------------------------------------------------------------------------
-- Name:   Example - FIRST_VALUE.sql
-- Date:   2019-07-13
-- Author: Mark Casazza
--
-- Purpose: Example of how FIRST_VALUE and LAST_VALUE work as an analytic functions.
--
-- Note: The example, Baruch in 1236, is a good example when tested 2022-11-18. Since it's in 
--       the future, the dates may change.
-------------------------------------------------------------------------------------------------
SELECT * FROM (
SELECT
  institution,
  strm,
  acad_career,
  term_begin_dt,
  FIRST_VALUE(term_begin_dt) OVER(
    PARTITION BY institution,
                 strm
    ORDER BY
      term_begin_dt
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
    ) first_term_begin_dt,
  term_end_dt,
  LAST_VALUE(term_end_dt) OVER(
    PARTITION BY institution,
                 strm
    ORDER BY
      term_end_dt
    ROWS BETWEEN UNBOUNDED PRECEDING AND UNBOUNDED FOLLOWING
  ) last_term_end_dt
FROM
  fnd_cf.ps_term_tbl
)
WHERE
      institution = 'BAR01'
  AND strm        = '1236'
  --term_begin_dt != first_term_begin_dt
ORDER BY
  1,2,3,4,5;