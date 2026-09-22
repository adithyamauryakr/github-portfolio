.PHONY: install serve build clean

install:
	uv sync

serve: install
	uv run mkdocs serve

build: install
	uv run mkdocs build --strict

clean:
	rm -rf site
