(defpackage skattelisten-csv-parser
  (:use
   :cl
   :str
   :unix-options)
  (:export
   :main))
(in-package :skattelisten-csv-parser)

(defstruct company
  cvr-num
  name
  se-num
  income-year
  company-type
  taxable
  taxable-income
  deficit
  corporate-tax)

(defun parse-file (fname thunk)
  (let ((collection '()))
    (with-open-file (stream fname
                            :external-format :utf-8)
      (do ((line (read-line stream nil)
                 (read-line stream nil)))
          ((null line))
        (push (funcall thunk (split "," line)) collection)))
    collection))

(defun create-company (attributes)
  (make-company
   :cvr-num (nth 0 attributes)
   :name (nth 1 attributes)
   :se-num (nth 2 attributes)
   :income-year (nth 3 attributes)
   :company-type (nth 5 attributes)
   :taxable (nth 7 attributes)
   :taxable-income (nth 8 attributes)
   :deficit (nth 9 attributes)
   :corporate-tax (nth 10 attributes)))

(defun run (fname)
  (print (length (parse-file fname #'create-company))))

(defun main ()
  (with-cli-options (uiop:*command-line-arguments*)
                    (&parameters f)
    (format t "Starting import of ~S.~%" f)
    (run f)
    (format t "Finished import.~%")))
