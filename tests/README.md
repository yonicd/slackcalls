Tests and Coverage
================
26 January, 2020 21:31:14

  - [Coverage](#coverage)
  - [Unit Tests](#unit-tests)

This output is created by
[covrpage](https://github.com/metrumresearchgroup/covrpage).

## Coverage

Coverage summary is created using the
[covr](https://github.com/r-lib/covr) package.

| Object                          | Coverage (%) |
| :------------------------------ | :----------: |
| slackcalls                      |     100      |
| [R/generics.R](../R/generics.R) |     100      |

<br>

## Unit Tests

Unit Test summary is created using the
[testthat](https://github.com/r-lib/testthat)
package.

| file                                        | n |  time | error | failed | skipped | warning |
| :------------------------------------------ | -: | ----: | ----: | -----: | ------: | ------: |
| [test-generics.R](testthat/test-generics.R) | 7 | 0.009 |     0 |      0 |       0 |       0 |

<details closed>

<summary> Show Detailed Test Results
</summary>

| file                                                | context  | test                            | status | n |  time |
| :-------------------------------------------------- | :------- | :------------------------------ | :----- | -: | ----: |
| [test-generics.R](testthat/test-generics.R#L21)     | generics | calls work: ok result           | PASS   | 1 | 0.001 |
| [test-generics.R](testthat/test-generics.R#L25_L31) | generics | calls work: names of return     | PASS   | 1 | 0.002 |
| [test-generics.R](testthat/test-generics.R#L67_L70) | generics | limits: limit attribute         | PASS   | 1 | 0.002 |
| [test-generics.R](testthat/test-generics.R#L74_L77) | generics | limits: limit messages          | PASS   | 1 | 0.002 |
| [test-generics.R](testthat/test-generics.R#L81_L84) | generics | limits: names of results object | PASS   | 1 | 0.000 |
| [test-generics.R](testthat/test-generics.R#L101)    | generics | maxes are respected: 200 length | PASS   | 1 | 0.001 |
| [test-generics.R](testthat/test-generics.R#L113)    | generics | maxes are respected: 200 length | PASS   | 1 | 0.001 |

</details>

<details>

<summary> Session Info </summary>

| Field    | Value                               |
| :------- | :---------------------------------- |
| Version  | R version 3.6.1 (2019-07-05)        |
| Platform | x86\_64-apple-darwin15.6.0 (64-bit) |
| Running  | macOS Mojave 10.14.5                |
| Language | en\_US                              |
| Timezone | America/New\_York                   |

| Package  | Version |
| :------- | :------ |
| testthat | 2.2.1   |
| covr     | 3.3.0   |
| covrpage | 0.0.70  |

</details>

<!--- Final Status : pass --->
