(defsystem "skattelisten-csv-parser"
  :version "0.1.0"
  :author "Rune Andreas Nielsen"
  :license ""
  :depends-on ("str")
  :components ((:module "src"
                :components
                ((:file "main"))))
  :description "CSV parser for the danish company tax list."
  :build-operation "program-op"
  :build-pathname "dist/skattelisten-csv-parser"
  :entry-point "skattelisten-csv-parser:main")
