LISP ?= sbcl

build:
	$(LISP) --eval '(asdf:load-system "skattelisten-csv-parser")' \
		--eval '(ql:quickload :skattelisten-csv-parser)' \
				--eval '(asdf:make :skattelisten-csv-parser)' \
				--eval '(quit)'
