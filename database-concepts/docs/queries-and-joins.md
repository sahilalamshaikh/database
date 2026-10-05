# Queries and Joins

SQL queries describe the data you want. The database engine chooses an
execution strategy to produce it. Clear queries start from the needed tables,
select relevant rows, and return only the columns required by the task.

## Filtering and projection

Projection selects columns; filtering selects rows. In SQL, `SELECT` names the
output columns and `WHERE` applies row conditions.

```sql
SELECT student_id, full_name
FROM student
WHERE full_name LIKE 'A%'
ORDER BY full_name;
```

Use explicit column names rather than `SELECT *` in application queries. It
makes the result shape clearer and avoids fetching columns the caller does not
need.

## Joining related tables

An inner join returns rows where the join condition matches on both sides.
This query lists students and the courses in which they are enrolled:

```sql
SELECT s.full_name, c.title, e.enrolled_on
FROM enrollment AS e
JOIN student AS s ON s.student_id = e.student_id
JOIN course AS c ON c.course_id = e.course_id
ORDER BY s.full_name, c.title;
```

The `ON` condition expresses how rows relate. Omitting or weakening it can
produce a Cartesian product, pairing every row from one table with every row
from another.

## Outer joins

A left join keeps every row from the left table, even when there is no match
on the right. Right-side columns are `NULL` for unmatched rows. To find
students with no enrollments:

```sql
SELECT s.student_id, s.full_name
FROM student AS s
LEFT JOIN enrollment AS e ON e.student_id = s.student_id
WHERE e.student_id IS NULL;
```

Be mindful of where conditions go. A condition on the right table in `WHERE`
can remove the unmatched rows and make an outer join behave like an inner
join. Conditions that should control matching can belong in the `ON` clause.

## Aggregation

Aggregate functions summarize groups. `GROUP BY` defines the groups, and
`HAVING` filters groups after aggregation.

```sql
SELECT course_id, COUNT(*) AS enrollment_count
FROM enrollment
GROUP BY course_id
HAVING COUNT(*) >= 10;
```

`WHERE` filters individual rows before grouping; `HAVING` filters aggregate
results. SQL dialects differ in some expression and alias rules, so verify
details when moving queries between engines.

## Check your understanding

1. What is the difference between filtering rows and selecting columns?
2. Which join keeps students who have no enrollments?
3. When should a condition use `HAVING` instead of `WHERE`?