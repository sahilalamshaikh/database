# Relationships and Normalization

Relationships describe how records in different tables are connected.
Normalization is the practice of structuring those tables to reduce
duplication and avoid update anomalies.

## One-to-one and one-to-many

A one-to-one relationship associates at most one row on each side. A one-to-many
relationship associates one row with multiple rows on the other side. For
example, one department may offer many courses; each course belongs to one
department. Store the department key on the course rows to represent that
relationship.

## Many-to-many

Students can take many courses, and each course can have many students. A
relational design represents this many-to-many relationship with a junction
table:

```sql
CREATE TABLE enrollment (
    student_id INTEGER NOT NULL REFERENCES student (student_id),
    course_id  INTEGER NOT NULL REFERENCES course (course_id),
    enrolled_on DATE NOT NULL,
    PRIMARY KEY (student_id, course_id)
);
```

The pair is the key because a student can enroll in a given course only once
in this model. Attributes such as `enrolled_on` belong to the relationship,
not to the student or course alone.

## Why normalize?

Suppose a table stores a course title and instructor details on every student
enrollment. The same course and instructor facts are repeated many times.
That duplication can cause anomalies:

- Updating an instructor's name requires changing many rows.
- Inserting a course may require inventing an enrollment before any student
  registers.
- Deleting the last enrollment could accidentally remove the only copy of
  course information.

Separate student, course, and instructor facts into their own tables, then
connect them using keys. Keep enrollment-specific facts in the enrollment
table.

## Functional dependencies

A functional dependency $A \to B$ means that a value of attribute set $A$
determines exactly one value of $B$. For example:

$$
	ext{course\_id} \to \text{title}
$$

If `course_id` determines `title`, then
storing both the course identifier and title in every enrollment repeats a
fact that belongs to the course relation.

Normalization forms provide progressively stronger ways to assess designs.
At an introductory level, aim for columns that hold one value per row, facts
stored with the key that determines them, and relationships represented with
foreign keys. Normalization is not a goal of eliminating all repetition at
any cost; performance and application requirements may justify carefully
chosen denormalization later.

## Check your understanding

1. Why is a separate enrollment table needed for students and courses?
2. Which attributes belong to an enrollment rather than a student?
3. Describe one update anomaly caused by repeating course details in every
   enrollment row.