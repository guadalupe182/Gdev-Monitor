PROJECT := gdev-tv
VERSION := 0.1.0

.PHONY: help init lint fmt test doctor run install uninstall clean

help:
	@echo ""
	@echo "GDEV TV MODE"
	@echo ""
	@echo " make init"
	@echo " make lint"
	@echo " make fmt"
	@echo " make test"
	@echo " make doctor"
	@echo " make run"
	@echo " make install"
	@echo " make uninstall"
	@echo " make clean"
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

doctor:
	@./bin/gdev-tv doctor

run:
	@./bin/gdev-tv

install:
	@chmod +x install.sh
	@./install.sh

uninstall:
	@chmod +x uninstall.sh
	@./uninstall.sh

clean:
	@find . -name "*.log" -delete
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
