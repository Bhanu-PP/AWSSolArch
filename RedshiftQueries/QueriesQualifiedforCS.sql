--burst activity qualified queries
SELECT CASE
         WHEN q.concurrency_scaling_status = 1 THEN 1
         ELSE 0
       END AS is_burst,
       COUNT(*) AS queries,
       SUM(q.aborted) AS aborted,
       SUM(ROUND(total_queue_time::NUMERIC/ 1000000,2)) AS queue_secs,
       SUM(ROUND(total_exec_time::NUMERIC/ 1000000,2)) AS exec_secs
FROM stl_query q
  JOIN stl_wlm_query w USING (userid,query)
WHERE q.userid > 1
AND   q.starttime > '1/24/2021 00:00'
AND   q.endtime < '1/24/2021 23:59'
group by 1
order by 1;