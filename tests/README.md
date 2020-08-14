Tests and Coverage
================
14 August, 2020 00:43:41

  - [Coverage](#coverage)
  - [Unit Tests](#unit-tests)

This output is created by
[covrpage](https://github.com/metrumresearchgroup/covrpage).

## Coverage

Coverage summary is created using the
[covr](https://github.com/r-lib/covr) package.

| Object                          | Coverage (%) |
| :------------------------------ | :----------: |
| slackcalls                      |    66.67     |
| [R/generics.R](../R/generics.R) |    66.67     |

<br>

## Unit Tests

Unit Test summary is created using the
[testthat](https://github.com/r-lib/testthat) package.

| file                                        | n |  time | error | failed | skipped | warning |
| :------------------------------------------ | -: | ----: | ----: | -----: | ------: | ------: |
| [test-generics.R](testthat/test-generics.R) | 8 | 0.046 |     0 |      0 |       0 |       0 |

<details closed>

<summary> Show Detailed Test Results </summary>

| file                                                | context  | test                            | status | n |  time |
| :-------------------------------------------------- | :------- | :------------------------------ | :----- | -: | ----: |
| [test-generics.R](testthat/test-generics.R#L18)     | generics | calls work: ok result           | PASS   | 1 | 0.034 |
| [test-generics.R](testthat/test-generics.R#L22_L28) | generics | calls work: names of return     | PASS   | 1 | 0.001 |
| [test-generics.R](testthat/test-generics.R#L42)     | generics | limits: more than 5             | PASS   | 1 | 0.002 |
| [test-generics.R](testthat/test-generics.R#L53_L56) | generics | limits: limit attribute         | PASS   | 1 | 0.002 |
| [test-generics.R](testthat/test-generics.R#L60_L63) | generics | limits: limit messages          | PASS   | 1 | 0.002 |
| [test-generics.R](testthat/test-generics.R#L67_L70) | generics | limits: names of results object | PASS   | 1 | 0.001 |
| [test-generics.R](testthat/test-generics.R#L87)     | generics | maxes are respected: 6 length   | PASS   | 1 | 0.002 |
| [test-generics.R](testthat/test-generics.R#L99)     | generics | maxes are respected: 6 length   | PASS   | 1 | 0.002 |

</details>

<details>

<summary> Session Info </summary>

| Field    | Value                             |                                                                                                                                                                                                                                                                    |
| :------- | :-------------------------------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Version  | R version 4.0.2 (2020-06-22)      |                                                                                                                                                                                                                                                                    |
| Platform | x86\_64-apple-darwin17.0 (64-bit) | <a href="https://github.com/yonicd/slackcalls/commit/051abb4ef693cab8a138606e8d0a7a4b70d094fa/checks" target="_blank"><span title="Built on Github Actions">![](https://github.com/metrumresearchgroup/covrpage/blob/actions/inst/logo/gh.png?raw=true)</span></a> |
| Running  | macOS Catalina 10.15.6            |                                                                                                                                                                                                                                                                    |
| Language | en\_US                            |                                                                                                                                                                                                                                                                    |
| Timezone | UTC                               |                                                                                                                                                                                                                                                                    |

| Package  | Version |
| :------- | :------ |
| testthat | 2.3.2   |
| covr     | 3.5.0   |
| covrpage | 0.0.71  |

</details>

<!--- Final Status : pass --->
