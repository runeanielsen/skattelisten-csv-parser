LISP ?= sbcl

build:
	$(LISP) --non-interactive \
				--eval '(asdf:load-system "skattelisten-csv-parser")' \
				--eval '(ql:quickload :skattelisten-csv-parser)' \
				--eval '(asdf:make :skattelisten-csv-parser)'
