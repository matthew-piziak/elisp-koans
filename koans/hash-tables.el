;;   Copyright 2013 Google Inc.
;;
;;   Licensed under the Apache License, Version 2.0 (the "License");
;;   you may not use this file except in compliance with the License.
;;   You may obtain a copy of the License at
;;
;;       http://www.apache.org/licenses/LICENSE-2.0
;;
;;   Unless required by applicable law or agreed to in writing, software
;;   distributed under the License is distributed on an "AS IS" BASIS,
;;   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
;;   See the License for the specific language governing permissions and
;;   limitations under the License.
;;
;;   based on python koans: about_dictionaries.py
;;
;;   Adapted from google/lisp-koans:koans/hash-tables.lsp

;; Relevant emacs info page: `(info "(elisp)Hash Tables")'

(elisp-koans/deftest
 elisp-koans/hash-tables-make ()
 "make a new hash table with `make-hash-table'"
 (let ((my-hash-table))
   (setf my-hash-table (make-hash-table))
   (should (eq t (typep my-hash-table 'hash-table)))
   (should (eq t  (hash-table-p my-hash-table)))
   (should (eq nil  (hash-table-p '(3 3 3))))
   (should (eq 0 (hash-table-count my-hash-table)))))


(elisp-koans/deftest
 elisp-koans/hash-tables-access ()
 "`gethash' is for accessing hash tables"
 (let ((table-of-cube-roots (make-hash-table)))
   "assign the key-value pair 1->'uno'"
   (setf (gethash 1 table-of-cube-roots) "uno")
   (should (equal "uno" (gethash 1 table-of-cube-roots)))
   (should (equal 1 (hash-table-count table-of-cube-roots)))

   (setf (gethash 8 table-of-cube-roots) 2)
   (setf (gethash -3 table-of-cube-roots) -27)
   (should (equal -27 (gethash -3 table-of-cube-roots)))
   (should (equal 3 (hash-table-count table-of-cube-roots)))
   "accessing unset keys returns nil"
   (should (equal nil (gethash 125 table-of-cube-roots)))))


(elisp-koans/deftest
 elisp-koans/hash-tables-key-equality ()
 "hash tables need to know how to tell if two keys are equivalent.
The programmer must be careful to know which equality predicate is right."
 (let ((hash-table-eq nil)
       (hash-table-equal nil)
       (hash-table-default nil))

   "define three hash tables, with different equality tests"
   (setf hash-table-eq (make-hash-table :test #'eq))
   (setf hash-table-equal (make-hash-table :test #'equal))
   (setf hash-table-default (make-hash-table))

   "add the same string twice, to each"
   (setf (gethash "one" hash-table-eq) "uno")
   (setf (gethash "one" hash-table-eq) "uno")

   (setf (gethash "one" hash-table-equal) "uno")
   (setf (gethash "one" hash-table-equal) "uno")

   (setf (gethash "one" hash-table-default) "uno")
   (setf (gethash "one" hash-table-default) "uno")

   "count how many unique key-value pairs in each"
   (should (eq 2 (hash-table-count hash-table-eq)))
   (should (eq 1 (hash-table-count hash-table-equal)))
   (should (eq 2 (hash-table-count hash-table-default)))))


(elisp-koans/deftest
 elisp-koans/hash-tables-equality ()
 "let's see how equality predicates work with hash tables"
 (let ((h1 (make-hash-table :test #'equal))
       (h2 (make-hash-table :test #'equal)))
   (setf (gethash "one" h1) "yat")
   (setf (gethash "one" h2) "yat")
   (setf (gethash "two" h1) "yi")
   (setf (gethash "two" h2) "yi")
   (should (eq nil (eq h1 h2)))
   (should (eq nil (equal h1 h2)))
   (should (eq nil (equalp h1 h2)))))

;;; hash-tables.el ends here
