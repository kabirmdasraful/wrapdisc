.PHONY: help clean fmt install prep setup test unittest

help:
	@echo "clean  : Remove auto-created files and directories."
	@echo "fmt    : Autoformat Python code in-place using various tools in sequence."
	@echo "install: Install requirements."
	@echo "prep   : Autoformat and run tests."
	@echo "setup  : Install requirements and run tests."
	@echo "test   : Run tests."

clean:
	rm -rf ./.mypy_cache ./.pytest_cache

fmt:
	isort .
	black .

install:
	pip install -U pip wheel
	pip install -U -U -r ./requirements-dev.in

prep: fmt test

setup: install test

test:
	black --check .
	vulture --exclude venv/ --make-whitelist . ./vulture.txt
	pytest -v

unittest:
	python -m unittest discover
