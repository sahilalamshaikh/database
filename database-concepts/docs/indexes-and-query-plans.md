# Indexes and Query Plans

An index is an auxiliary data structure that helps a database locate rows
without scanning an entire table. Indexes can speed up reads, but they also
consume storage and add work to inserts, updates, and deletes.

## Choosing an index

Indexes are useful when a query frequently filters, joins, or orders by a
column. For example, if the application often finds enrollments by course,
an index on `course_id` may help:

```sql
CREATE INDEX enrollment_course_id_idx
ON enrollment (course_id);
```

The primary key `(student_id, course_id)` already begins with `student_id`,
which can help queries filtering by student. It generally does not provide the
same access path for filtering only by `course_id`; composite index column
order matters.

Do not index every column. Consider query frequency, selectivity, write rate,
storage, and indexes already created to enforce keys. Validate choices with
representative data and workload.

## Reading a query plan

A query plan describes how the engine expects to execute a query. Depending on
the engine, it may show table scans, index scans, join algorithms, estimated
row counts, and costs. Use the engine's `EXPLAIN` tooling to investigate a slow
query, then compare estimates with actual behavior when the engine supports
that safely.

An index scan is not automatically better than a table scan. If a query needs
many rows, reading the whole table sequentially may cost less than locating
many scattered rows through an index. The optimizer chooses a plan based on
statistics and cost estimates.

## Practical tuning loop

1. Identify a query that matters using measurements, not guesswork.
2. Inspect its plan and verify the predicates and join conditions.
3. Check whether table statistics are current and estimates are reasonable.
4. Make one change, such as an index or a query rewrite.
5. Measure representative reads and writes again.

Plan output and index behavior are engine-specific. Consult the matching
MySQL, PostgreSQL, or SQL Server project before applying a particular
optimization technique.

## Check your understanding

1. What costs do indexes add to write operations?
2. Why can an existing composite index fail to help a query on its second
   column alone?
3. Why is a table scan sometimes a reasonable plan?