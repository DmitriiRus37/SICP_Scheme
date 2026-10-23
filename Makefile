# Requires Racket (https://racket-lang.org) and the cover package:
#   raco pkg install --auto cover
MIN_COVERAGE ?= 90

.PHONY: test coverage coverage-html clean

test:
	raco test tests

# Runs the tests under raco cover and fails if line coverage of the
# exercise files is below $(MIN_COVERAGE)%.
coverage:
	racket scripts/check-coverage.rkt $(MIN_COVERAGE)

# HTML report in coverage/ (exercise files only)
coverage-html:
	raco cover -d coverage -n tests -n scripts .

clean:
	rm -rf coverage compiled tests/compiled scripts/compiled
