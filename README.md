# Skattelisten csv parser

Parses the CSV files from [here](https://www.sktst.dk/aktuelt/skatteoplysninger-for-selskaber/).

## NOTE

This was made to play with common lisp if you want a much faster solution use [this](https://github.com/strnx/skattelisten-import).

## Use

```sh
./skattelisten-csv-parser -i "my-input-file.csv" -o "my-output-file.json"
```

## Build

To compile the project run the `MakeFile` in the project root.

## Development

1. Load the project using quicklisp

```lisp
(ql:quickload "skattelisten-csv-parser")
```

2. in-package the project
```lisp
(in-package :skattelisten-csv-parser)
```
