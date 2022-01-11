--finger query - find queries for given table

select
md5(
regexp_replace(
  regexp_replace(
     regexp_replace(
       regexp_replace(q.querytxt, '[[:space:]]+',' '),
       '''[^\‘]*‘’',''':STR’‘' ),
     '([\(\=\<\>\+, -])[0-9]+\.?[0-9]*','\\1:NUM'),
  '[[:digit:]] + ',' ')
) sql_fingerprint_hash,
count(*) count,
min(datediff('second', q.starttime, q.endtime)) min_time,
max(datediff('second', q.starttime, q.endtime)) max_time,
avg(datediff('second', q.starttime, q.endtime)) avg_time,
max(datediff('second', w.exec_start_time, w.exec_end_time)) max_exec_time,
sum(datediff('second', w.exec_start_time, w.exec_end_time)) total_exec_time,
avg(datediff('second', w.exec_start_time, w.exec_end_time)) avg_exec_time,
min(io_skew) min_ioskew,
max(io_skew) max_ioskew,
avg(io_skew) avg_ioskew,
max(q.query) sample_query,substring(max(q.querytxt), 1, 100)from stl_query q join svl_query_metrics_summary m
  on q.query=m.query
join stl_wlm_query w on w.query=q.query
where q.userid > 1 --and q.endtime > getdate() - interval '24 hour'
and q.querytxt like '%YOUR_TABLE_NAME%' --<Add your table name here
group by sql_fingerprint_hash
order by total_exec_time desc
limit 25;
