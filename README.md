# SICP_Scheme

Solutions to SICP chapter 1 exercises in Racket.

## Tests and coverage

The rackunit tests live in `tests/`. With [Racket](https://racket-lang.org) and the
`cover` package (`raco pkg install --auto cover`) installed:

```sh
make test           # raco test tests
make coverage       # tests under raco cover, fails below 90% line coverage
make coverage-html  # HTML report in coverage/
```

`1.2` is a DrRacket (WXME) file and is not part of the test run.
