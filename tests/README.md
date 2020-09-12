Tests and Coverage
================
12 September, 2020 00:15:31

  - [Coverage](#coverage)
  - [Unit Tests](#unit-tests)

This output is created by
[covrpage](https://github.com/metrumresearchgroup/covrpage).

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
| [test-chat.R](testthat/test-chat.R)         |  6 | 0.130 |     0 |      0 |       0 |       0 |
| [test-files.R](testthat/test-files.R)       | 10 | 0.014 |     0 |      0 |       0 |       0 |
| [test-generics.R](testthat/test-generics.R) | 10 | 0.011 |     0 |      0 |       0 |       0 |

<details closed>

<summary> Show Detailed Test Results </summary>

| file                                                | context  | test                                            | status | n |  time |
| :-------------------------------------------------- | :------- | :---------------------------------------------- | :----- | -: | ----: |
| [test-chat.R](testthat/test-chat.R#L15)             | chat     | chat upload: ok result                          | PASS   | 1 | 0.034 |
| [test-chat.R](testthat/test-chat.R#L19_L22)         | chat     | chat upload: names of return                    | PASS   | 1 | 0.001 |
| [test-chat.R](testthat/test-chat.R#L26_L32)         | chat     | chat upload: last\_post returns attribs         | PASS   | 1 | 0.001 |
| [test-chat.R](testthat/test-chat.R#L36)             | chat     | chat upload: query stack                        | PASS   | 1 | 0.001 |
| [test-chat.R](testthat/test-chat.R#L50)             | chat     | chat upload: remove post                        | PASS   | 1 | 0.090 |
| [test-chat.R](testthat/test-chat.R#L56)             | chat     | chat upload: empty stack                        | PASS   | 1 | 0.003 |
| [test-files.R](testthat/test-files.R#L16)           | files    | content upload: ok result                       | PASS   | 1 | 0.001 |
| [test-files.R](testthat/test-files.R#L20_L23)       | files    | content upload: names of return                 | PASS   | 1 | 0.001 |
| [test-files.R](testthat/test-files.R#L27)           | files    | content upload: file\_last returns file id      | PASS   | 1 | 0.002 |
| [test-files.R](testthat/test-files.R#L31)           | files    | content upload: file\_stack equal to last\_file | PASS   | 1 | 0.001 |
| [test-files.R](testthat/test-files.R#L42)           | files    | file list: ok result                            | PASS   | 1 | 0.002 |
| [test-files.R](testthat/test-files.R#L52)           | files    | file info: ok result                            | PASS   | 1 | 0.001 |
| [test-files.R](testthat/test-files.R#L56)           | files    | file info: file info content                    | PASS   | 1 | 0.002 |
| [test-files.R](testthat/test-files.R#L74)           | files    | file upload: ok result                          | PASS   | 1 | 0.001 |
| [test-files.R](testthat/test-files.R#L78)           | files    | file upload: ok result                          | PASS   | 1 | 0.001 |
| [test-files.R](testthat/test-files.R#L86)           | files    | file upload: empty stack                        | PASS   | 1 | 0.002 |
| [test-generics.R](testthat/test-generics.R#L18)     | generics | calls work: ok result                           | PASS   | 1 | 0.001 |
| [test-generics.R](testthat/test-generics.R#L22_L28) | generics | calls work: names of return                     | PASS   | 1 | 0.001 |
| [test-generics.R](testthat/test-generics.R#L43)     | generics | call error: ok FALSE                            | PASS   | 1 | 0.001 |
| [test-generics.R](testthat/test-generics.R#L47)     | generics | call error: ok FALSE                            | PASS   | 1 | 0.001 |
| [test-generics.R](testthat/test-generics.R#L60)     | generics | limits: more than 5                             | PASS   | 1 | 0.001 |
| [test-generics.R](testthat/test-generics.R#L71_L74) | generics | limits: limit attribute                         | PASS   | 1 | 0.002 |
| [test-generics.R](testthat/test-generics.R#L78_L81) | generics | limits: limit messages                          | PASS   | 1 | 0.001 |
| [test-generics.R](testthat/test-generics.R#L85_L88) | generics | limits: names of results object                 | PASS   | 1 | 0.001 |
| [test-generics.R](testthat/test-generics.R#L105)    | generics | maxes are respected: 6 length                   | PASS   | 1 | 0.001 |
| [test-generics.R](testthat/test-generics.R#L117)    | generics | maxes are respected: 6 length                   | PASS   | 1 | 0.001 |

</details>

<details>

<summary> Session Info </summary>

| Field    | Value                             |                                                                                                                                                                                                                                                                    |
| :------- | :-------------------------------- | :----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- |
| Version  | R version 4.0.2 (2020-06-22)      |                                                                                                                                                                                                                                                                    |
| Platform | x86\_64-apple-darwin17.0 (64-bit) | <a href="https://github.com/yonicd/slackcalls/commit/6ab1454705168efec3d5c45c6cff50d1e9b10ec3/checks" target="_blank"><span title="Built on Github Actions">![](https://github.com/metrumresearchgroup/covrpage/blob/actions/inst/logo/gh.png?raw=true)</span></a> |
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
