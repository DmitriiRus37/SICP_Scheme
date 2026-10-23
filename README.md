# SICP_Scheme

Solutions to the chapter 1 exercises of *Structure and Interpretation of Computer Programs*
(SICP), written in Racket. Each `N.M task.rkt` file solves one exercise; the other files cover
the chapter's worked topics (Euclid's algorithm, fast exponentiation, the Fermat test, searching
for divisors, procedures as arguments). Every exercise is covered by rackunit tests.

## Tech stack

- Racket 9.x, rackunit, the `cover` package for coverage

## Tests and coverage

The rackunit tests live in `tests/`. With [Racket](https://racket-lang.org) and the
`cover` package (`raco pkg install --auto cover`) installed:

```sh
make test           # raco test tests
make coverage       # tests under raco cover, fails below 90% line coverage
make coverage-html  # HTML report in coverage/
```

`1.2` is a DrRacket (WXME) file and is not part of the test run.

## Run

Open any `.rkt` file in DrRacket, or run it from the shell: `racket "1.3 task.rkt"`.
