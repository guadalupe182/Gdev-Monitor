PROJECT := gdev-monitor
VERSION := 0.1.0

.PHONY: help init lint fmt test run tv laptop doctor status install uninstall clean

help:
	@echo ""
	@echo "GDEV Monitor"
	@echo ""
	@echo "make run"
	@echo "make tv"
	@echo "make laptop"
	@echo "make doctor"
	@echo "make status"
	@echo "make lint"
	@echo "make fmt"
	@echo "make test"
	@echo "make clean"
	@echo ""

init:
	@echo "Checking dependencies..."
	@command -v bash >/dev/null || exit 1
	@command -v shellcheck >/dev/null || echo "Missing shellcheck"
	@command -v shfmt >/dev/null || echo "Missing shfmt"

lint:
	@find . -type f -name "*.sh" -exec shellcheck {} \;

fmt:
	@find . -type f -name "*.sh" -exec shfmt -w {} \;

test:
	@echo "No tests yet."

run:
	./bin/gdev

tv:
	./bin/gdev tv

laptop:
	./bin/gdev laptop

doctor:
	./bin/gdev doctor

status:
	./bin/gdev status

install:
	@echo "Install (coming soon)"

uninstall:
	@echo "Uninstall (coming soon)"

clean:
	@find . -name "*.log" -delete
