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
;;   Adapted from google/lisp-koans:koans/format.lsp


;; FORMAT is lisp's counterpart to the c function printf. Refer to
;; http://www.gigamonkeys.com/book/a-few-format-recipes.html for more
;; on this topic.


;; FORMAT takes two fixed parameters. The first one specifies an
;; output stream that the result goes to, and if left as nil, FORMAT
;; will return the output as a string instead. The second parameter
;; specifies the format, where format specifier will be replaced by
;; formatting the rest of the parameters.

(elisp-koans/deftest
 elisp-koans/format-with-plain-text ()
 "If there is no format specifier, FORMAT just returns the string itself."
 (should (equal "this is plain text." (format "this is plain text."))))


(elisp-koans/deftest
 elisp-koans/format-with-general-specifier ()
 "%s is a general specifier that translates to the print form of a
parameter."
 (should (equal "42" (format "%s" 42)))
 (should (equal "67" (format "%s" ?C)))
 (should (equal "multiple arguments" (format "%s %s" "multiple" 'arguments)))
 (should (equal "galaxy far far away" (format "%s" "galaxy far far away")))
 ;; %s can also translate to list
 ;; and parameters to FORMAT are passed by value
 (should (equal "(/ 8 (- 3 (/ 8 3))) evaluates to 8"
                (format "%s evaluates to %s"
                        '(/ 8 (- 3 (/ 8 3)))
                        (/ 8 (- 3 (/ 8 3)))))))


(elisp-koans/deftest
 elisp-koans/format-numeric-control-sequences ()
 "=format= accepts other numeric control sequences"
 "=%d= specifies a decimal number"
 (should (equal "42" (format "%d" 42)))
 (should (equal "42" (format "%d" #o52)))
 (should (equal "42" (format "%d" #x2A)))
 "=%o= specifies an octal number"
 (should (equal "52" (format "%o" 42)))
 "=%x= specifies a hex number with lowercase characters"
 (should (equal "2a" (format "%x" 42)))
 "=%X= specifies a hex number with capital characters"
 (should (equal "2A" (format "%X" 42)))
 "=%f= specifies a decimal decimal point number"
 (should (equal "42.000000" (format "%f" 42))))

;; format.el ends here
