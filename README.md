# Database Learning Workspace

A Python monorepo for learning database fundamentals and comparing MySQL,
PostgreSQL, and SQL Server. Each directory is an independent uv project; the
three database-specific projects share the `database-concepts` package.

## Projects

- `database-concepts`: relational database fundamentals shared across engines.
- `mysql`: MySQL-specific examples and exercises.
- `postgres`: PostgreSQL-specific examples and exercises.
- `sqlserver`: SQL Server-specific examples and exercises.

## Getting started

Install [uv](https://docs.astral.sh/uv/), then sync all workspace projects:

```sh
uv sync --all-packages
```

Run Python in a specific project with `uv run --package`, for example:

```sh
uv run --package database-concepts python
uv run --package database-mysql python
uv run --package database-postgres python
uv run --package database-sqlserver python
```

Add a dependency to one project from that project's directory with `uv add`.
Workspace dependencies are declared in each project's `pyproject.toml` and
resolve to the local `database-concepts` project.