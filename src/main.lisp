(defpackage skattelisten-csv-parser
  (:use
   :cl
   :str
   :unix-options
   :jonathan)
  (:export
   :main))
(in-package :skattelisten-csv-parser)

(defclass company ()
  ((cvr :type string :initarg :cvr)
   (name :type string :initarg :name)
   (se :type string :initarg :se)
   (income-year :type int :initarg :income-year)
   (company-type :type string :initarg :company-type)
   (taxable-income :type int :initarg :taxable-income)
   (deficit :type int :initarg :deficit)
   (corporate-tax :type int :initarg :corporate-tax)))

(defmethod %to-json ((company company))
  (with-object
    (write-key-value "cvr" (slot-value company 'cvr))
    (write-key-value "name" (slot-value company 'name))
    (write-key-value "se" (slot-value company 'se))
    (write-key-value "incomeYear" (slot-value company 'income-year))
    (write-key-value "companyType" (slot-value company 'company-type))
    (write-key-value "taxableIncome" (slot-value company 'taxable-income))
    (write-key-value "deficit" (slot-value company 'deficit))
    (write-key-value "corporateTax" (slot-value company 'corporate-tax))))

(defun parse-file (fname thunk)
  (let ((collection '()))
    (with-open-file (stream fname
                            :external-format :utf-8)
      (do ((line (read-line stream nil)
                 (read-line stream nil)))
          ((null line))
        (push (funcall thunk (coerce (split "," line) 'vector)) collection)))
    collection))

(defun write-json-to-file (fname objects)
  (with-open-file (stream fname
                          :direction :output
                          :if-exists :supersede
                          :if-does-not-exist :create)
    (format stream "[")
    (dolist (object (without-last objects))
      (format stream "~A\," (to-json object)))
    (format stream "~A]" (to-json (first (last objects))))
    (terpri stream)))

(defun create-company (attributes)
  (make-instance 'company
                 :cvr (aref attributes 0)
                 :name (aref attributes 1)
                 :se (aref attributes 2)
                 :income-year (aref attributes 3)
                 :company-type (aref attributes 5)
                 :taxable-income (aref attributes 8)
                 :deficit (aref attributes 9)
                 :corporate-tax (aref attributes 10)))

(defun run (input-file output-file)
  ; Taking the rest of the list because of first column being invalid.
  (time (write-json-to-file output-file
                      (rest (parse-file input-file #'create-company)))))

(defun without-last (l)
  (reverse (cdr (reverse l))))

(defun main ()
  (with-cli-options (uiop:*command-line-arguments*)
                    (&parameters i o)
    (format t "Starting import of ~S.~%" i)
    (run i o)
    (format t "Finished import. Wrote to file ~S ~%" o)))

