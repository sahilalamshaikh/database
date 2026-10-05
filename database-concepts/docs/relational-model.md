# The Relational Model

The relational model organizes data into relations, commonly presented as
tables. A table has a defined set of columns, and each row represents one
record. Thinking in terms of meaning and rules, not just spreadsheets, is the
first step toward a reliable database design.

## Relations, rows, and columns

Consider a relation for students:

| student_id | full_name | email |
| --- | --- | --- |
| 101 | Amina Yusuf | amina@example.edu |
| 102 | Daniel Kim | daniel@example.edu |

The relation has three attributes (columns). Each tuple (row) describes one
student. A relation's heading describes its attributes; its body is the set of
tuples currently stored.

In the relational model, a relation is a set, so duplicate tuples have no
meaning. SQL tables can contain duplicate rows unless constraints prevent
them, which is one reason keys matter.

## Schema and data

A schema describes the structure and rules for data. The current rows are the
database state. The schema can stay stable while the state changes as records
are inserted, updated, and deleted.

```sql
CREATE TABLE student (
    student_id INTEGER,
    full_name  VARCHAR(200),
    email      VARCHAR(320)
);
```

This statement describes columns and broad types, but it does not yet state
which values are required or how a student is uniquely identified. Those
rules are constraints, covered in [Keys and Constraints](keys-and-constraints.md).

## Choosing attributes

Each column should represent one fact about the row's subject. For example,
store `given_name` and `family_name` separately if the application needs to
sort, search, or address those parts independently. Avoid putting repeating
values such as several course codes into one `courses` text column; model
individual facts as rows and connect them with relationships.

Choose types that reflect the values being stored. Identifiers, dates, exact
amounts, and free-form text have different requirements. Type names and edge
cases vary by database engine, so use this chapter's ideas as a guide and check
the engine-specific documentation when implementing a schema.

## Null is not zero

`NULL` represents missing or unknown information; it is not an empty string,
zero, or the ordinary value "unknown". Comparisons with `NULL` use `IS NULL`
and `IS NOT NULL`, because ordinary equality comparisons produce an unknown
result when either side is `NULL`.

```sql
SELECT student_id, full_name
FROM student
WHERE email IS NULL;
```

Use nullable columns only when absence is meaningful. If a fact must always be
known, declare the column `NOT NULL`.

## Check your understanding

1. What is the difference between a table's schema and its current state?
2. Why might a list of course codes in one text column cause problems?
3. How should a query find rows whose email is missing?