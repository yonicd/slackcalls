Tests and Coverage
================
18 February, 2023 02:51:06

  - [Coverage](#coverage)
  - [Unit Tests](#unit-tests)

This output is created by
[covrpage](https://github.com/yonicd/covrpage).

## Coverage

Coverage summary is created using the
[covr](https://github.com/r-lib/covr) package.

| Object                               | Coverage (%) |
| :----------------------------------- | :----------: |
| slackcalls                           |    92.66     |
| [R/manage.R](../R/manage.R)          |    90.91     |
| [R/generics.R](../R/generics.R)      |    91.74     |
| [R/rate\_limit.R](../R/rate_limit.R) |    97.06     |

<br>

## Unit Tests

Unit Test summary is created using the
[testthat](https://github.com/r-lib/testthat) package.

| file                                        |  n |  time | error | failed | skipped | warning |
| :------------------------------------------ | -: | ----: | ----: | -----: | ------: | ------: |
| [test-chat.R](testthat/test-chat.R)         |  7 | 0.507 |     0 |      0 |       0 |       0 |
| [test-files.R](testthat/test-files.R)       | 15 | 1.048 |     0 |      0 |       0 |       0 |
| [test-generics.R](testthat/test-generics.R) | 21 | 7.211 |     0 |      0 |       0 |       0 |

<details closed>

<summary> Show Detailed Test Results </summary>

| file                                                  | context  | test                                          | status | n |  time |
| :---------------------------------------------------- | :------- | :-------------------------------------------- | :----- | -: | ----: |
| [test-chat.R](testthat/test-chat.R#L49_L57)           | chat     | chat\_slack (etc) works                       | PASS   | 5 | 0.371 |
| [test-chat.R](testthat/test-chat.R#L84_L94)           | chat     | cleanup works                                 | PASS   | 2 | 0.136 |
| [test-files.R](testthat/test-files.R#L49_L58)         | files    | files\_slack can upload text                  | PASS   | 5 | 0.207 |
| [test-files.R](testthat/test-files.R#L79_L84)         | files    | files\_slack can list files                   | PASS   | 2 | 0.180 |
| [test-files.R](testthat/test-files.R#L90_L98)         | files    | files\_slack can get info                     | PASS   | 3 | 0.072 |
| [test-files.R](testthat/test-files.R#L123_L132)       | files    | files\_slack can upload files                 | PASS   | 3 | 0.208 |
| [test-files.R](testthat/test-files.R#L139_L152)       | files    | files\_slack can clean up                     | PASS   | 2 | 0.381 |
| [test-generics.R](testthat/test-generics.R#L56_L65)   | generics | post\_slack works                             | PASS   | 3 | 0.076 |
| [test-generics.R](testthat/test-generics.R#L79_L91)   | generics | post\_slack creates appropriate error objects | PASS   | 4 | 0.051 |
| [test-generics.R](testthat/test-generics.R#L98_L106)  | generics | post\_slack limits work                       | PASS   | 6 | 0.492 |
| [test-generics.R](testthat/test-generics.R#L139_L149) | generics | post\_slack respects max                      | PASS   | 4 | 0.363 |
| [test-generics.R](testthat/test-generics.R#L192_L203) | generics | rate limits work                              | PASS   | 4 | 6.229 |

</details>

<details>

<summary> Session Info </summary>

| Field    | Value                         |                                                                                                                                                                                                                                                                    |
| :------- | :---------------------------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Version  | R version 4.2.2 (2022-10-31)  |                                                                                                                                                                                                                                                                    |
| Platform | x86\_64-pc-linux-gnu (64-bit) | <a href="https://github.com/yonicd/slackcalls/commit/eb584aaafe778e19e415595e752feb555874de5f/checks" target="_blank"><span title="Built on Github Actions">![](https://github.com/metrumresearchgroup/covrpage/blob/actions/inst/logo/gh.png?raw=true)</span></a> |
| Running  | Ubuntu 22.04.1 LTS            |                                                                                                                                                                                                                                                                    |
| Language | C                             |                                                                                                                                                                                                                                                                    |
| Timezone | UTC                           |                                                                                                                                                                                                                                                                    |

| Package  | Version |
| :------- | :------ |
| testthat | 3.1.6   |
| covr     | 3.6.1   |
| covrpage | 0.2     |

</details>

<!--- Final Status : pass --->
