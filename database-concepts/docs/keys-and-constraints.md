# Keys and Constraints

Constraints are rules enforced by the database. They protect data no matter
which application or user writes it. Keys are constraints and design concepts
that identify rows and connect tables.

## Candidate and primary keys

A candidate key is a minimal set of attributes that uniquely identifies a row.
For a student table, `student_id` may be the candidate key. An email address
could also be unique in some applications, but it may change or be absent.

The designer chooses one candidate key as the primary key. A primary key must
be unique and non-null. Other candidate keys can be enforced with `UNIQUE`.

```sql
CREATE TABLE student (
    student_id INTEGER PRIMARY KEY,
    full_name  VARCHAR(200) NOT NULL,
    email      VARCHAR(320) NOT NULL UNIQUE
);
```

Surrogate keys, such as generated numeric identifiers, are separate from the
real-world facts about a record. Natural keys use meaningful domain values.
Either choice should be stable and reliably unique for the table's purpose.

## Foreign keys

A foreign key requires a value in one table to refer to an existing key in
another table. It prevents an enrollment from referring to a student who does
not exist.

```sql
CREATE TABLE enrollment (
    student_id INTEGER NOT NULL,
    course_id  INTEGER NOT NULL,
    enrolled_on DATE NOT NULL,
    PRIMARY KEY (student_id, course_id),
    FOREIGN KEY (student_id) REFERENCES student (student_id)
);
```

Foreign keys can also define what happens when a referenced row is updated or
deleted. Cascading actions can be useful, but they should reflect the domain
rules; they should not be selected merely to avoid handling deletions
explicitly.

## Other useful constraints

- `NOT NULL` requires a value.
- `UNIQUE` prevents duplicate values (or duplicate combinations of columns).
- `CHECK` restricts values to a condition, such as a non-negative credit count.
- `DEFAULT` supplies a value when an insert omits the column.

```sql
CREATE TABLE course (
    course_id INTEGER PRIMARY KEY,
    title     VARCHAR(200) NOT NULL,
    credits   INTEGER NOT NULL CHECK (credits > 0)
);
```

Constraint syntax and behavior have engine-specific details. For example,
support for particular `CHECK` features differs across database versions.

## Check your understanding

1. What makes a candidate key minimal?
2. What invalid state does the enrollment foreign key prevent?
3. When might `UNIQUE` be a better fit than choosing a value as the primary
   key?