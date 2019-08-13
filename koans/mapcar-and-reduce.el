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
;;   google/lisp-koans:koans/mapcar-and-reduce.lsp

(elisp-koans/deftest
 elisp-koans/mapcar-basics ()
 "apply a function to each member of a list using `mapcar'"
 (defun times-two (x) (* x 2))
 (should (equal '(2 4 6) (mapcar #'times-two '(1 2 3))))
 (should (equal '(3 "little" "pigs") (mapcar #'first '((3 2 1)
                                                       ("little" "small" "tiny")
                                                       ("pigs" "hogs" "swine"))))))


(elisp-koans/deftest
 elisp-koans/reduce-basics ()
 "The `reduce 'function combines the elements of a list, from left to right,
by applying a binary function to the list elements."
 (should (equal 10  (reduce #'+ '(1 2 3 4))))
 (should (equal 64 (reduce #'expt '(2 3 2)))))

;; mapcar-and-reduce.el ends here
