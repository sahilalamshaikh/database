.DEFAULT_GOAL := help

.PHONY: help sync docs docs-build

help:
	@printf '%s\n' \
		'sync       Install all workspace projects' \
		'docs       Serve documentation locally' \
		'docs-build Build documentation in strict mode'

sync:
	uv sync --all-packages

docs:
	uv run --group docs mkdocs serve --livereload

docs-build:
	uv run --group docs mkdocs build --strict