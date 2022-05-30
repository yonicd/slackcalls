Tests and Coverage
================
30 May, 2022 16:28:57

  - [Coverage](#coverage)
  - [Unit Tests](#unit-tests)

This output is created by
[covrpage](https://github.com/yonicd/covrpage).

## Coverage

Coverage summary is created using the
[covr](https://github.com/r-lib/covr) package.

| Object                          | Coverage (%) |
| :------------------------------ | :----------: |
| slackcalls                      |    95.24     |
| [R/generics.R](../R/generics.R) |    94.23     |
| [R/manage.R](../R/manage.R)     |    100.00    |

<br>

## Unit Tests

Unit Test summary is created using the
[testthat](https://github.com/r-lib/testthat) package.

| file                                        |  n |  time | error | failed | skipped | warning |
| :------------------------------------------ | -: | ----: | ----: | -----: | ------: | ------: |
| [test-chat.R](testthat/test-chat.R)         |  6 | 0.259 |     0 |      0 |       0 |       0 |
| [test-files.R](testthat/test-files.R)       | 10 | 0.046 |     0 |      0 |       0 |       0 |
| [test-generics.R](testthat/test-generics.R) | 10 | 0.025 |     0 |      0 |       0 |       0 |

<details closed>

<summary> Show Detailed Test Results </summary>

| file                                                | context  | test                                            | status | n |  time |
| :-------------------------------------------------- | :------- | :---------------------------------------------- | :----- | -: | ----: |
| [test-chat.R](testthat/test-chat.R#L15)             | chat     | chat upload: ok result                          | PASS   | 1 | 0.131 |
| [test-chat.R](testthat/test-chat.R#L19_L22)         | chat     | chat upload: names of return                    | PASS   | 1 | 0.002 |
| [test-chat.R](testthat/test-chat.R#L26_L32)         | chat     | chat upload: last\_post returns attribs         | PASS   | 1 | 0.002 |
| [test-chat.R](testthat/test-chat.R#L36)             | chat     | chat upload: query stack                        | PASS   | 1 | 0.006 |
| [test-chat.R](testthat/test-chat.R#L50)             | chat     | chat upload: remove post                        | PASS   | 1 | 0.115 |
| [test-chat.R](testthat/test-chat.R#L56)             | chat     | chat upload: empty stack                        | PASS   | 1 | 0.003 |
| [test-files.R](testthat/test-files.R#L16)           | files    | content upload: ok result                       | PASS   | 1 | 0.006 |
| [test-files.R](testthat/test-files.R#L20_L23)       | files    | content upload: names of return                 | PASS   | 1 | 0.002 |
| [test-files.R](testthat/test-files.R#L27)           | files    | content upload: file\_last returns file id      | PASS   | 1 | 0.011 |
| [test-files.R](testthat/test-files.R#L31)           | files    | content upload: file\_stack equal to last\_file | PASS   | 1 | 0.002 |
| [test-files.R](testthat/test-files.R#L42)           | files    | file list: ok result                            | PASS   | 1 | 0.008 |
| [test-files.R](testthat/test-files.R#L52)           | files    | file info: ok result                            | PASS   | 1 | 0.006 |
| [test-files.R](testthat/test-files.R#L56)           | files    | file info: file info content                    | PASS   | 1 | 0.002 |
| [test-files.R](testthat/test-files.R#L74)           | files    | file upload: ok result                          | PASS   | 1 | 0.005 |
| [test-files.R](testthat/test-files.R#L78)           | files    | file upload: ok result                          | PASS   | 1 | 0.001 |
| [test-files.R](testthat/test-files.R#L86)           | files    | file upload: empty stack                        | PASS   | 1 | 0.003 |
| [test-generics.R](testthat/test-generics.R#L18)     | generics | calls work: ok result                           | PASS   | 1 | 0.005 |
| [test-generics.R](testthat/test-generics.R#L22_L28) | generics | calls work: names of return                     | PASS   | 1 | 0.001 |
| [test-generics.R](testthat/test-generics.R#L43)     | generics | call error: ok FALSE                            | PASS   | 1 | 0.006 |
| [test-generics.R](testthat/test-generics.R#L47)     | generics | call error: ok FALSE                            | PASS   | 1 | 0.001 |
| [test-generics.R](testthat/test-generics.R#L60)     | generics | limits: more than 5                             | PASS   | 1 | 0.002 |
| [test-generics.R](testthat/test-generics.R#L71_L74) | generics | limits: limit attribute                         | PASS   | 1 | 0.003 |
| [test-generics.R](testthat/test-generics.R#L79_L82) | generics | limits: limit messages                          | PASS   | 1 | 0.001 |
| [test-generics.R](testthat/test-generics.R#L86_L89) | generics | limits: names of results object                 | PASS   | 1 | 0.002 |
| [test-generics.R](testthat/test-generics.R#L106)    | generics | maxes are respected: 6 length                   | PASS   | 1 | 0.002 |
| [test-generics.R](testthat/test-generics.R#L121)    | generics | maxes are respected: 15 length                  | PASS   | 1 | 0.002 |

</details>

<details>

<summary> Session Info </summary>

| Field    | Value                               |                                                                                                                                                                                                                                                                    |
| :------- | :---------------------------------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Version  | R version 4.2.0 (2022-04-22)        |                                                                                                                                                                                                                                                                    |
| Platform | x86\_64-apple-darwin20.6.0 (64-bit) | <a href="https://github.com/yonicd/slackcalls/commit/a5c53e7be2e7e064c3a02fe69248124bc7becdfa/checks" target="_blank"><span title="Built on Github Actions">![](https://github.com/metrumresearchgroup/covrpage/blob/actions/inst/logo/gh.png?raw=true)</span></a> |
| Running  | macOS Big Sur 11.6.6                |                                                                                                                                                                                                                                                                    |
| Language | en\_US                              |                                                                                                                                                                                                                                                                    |
| Timezone | UTC                                 |                                                                                                                                                                                                                                                                    |

| Package  | Version |
| :------- | :------ |
| testthat | 3.1.4   |
| covr     | 3.5.1   |
| covrpage | 0.1     |

</details>

<!--- Final Status : pass --->
