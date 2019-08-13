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
;;   Adapted from google/lisp-koans:koans/structures.lsp


;; [Common] Lisp structures encapsulate data which belongs together. They are a
;; template of sorts, providing a way to generate multiple instances of
;; uniformly organized information
;;
;; Defining a struct also interns accessor functions to get and set the fields
;; of the structure.


;; Define a new struct with the cl-defstruct form. The following call creates a
;; new structure type named basketball-player, with slots named: 'name', 'team',
;; and number.
(cl-defstruct basketball-player name team number)

(elisp-koans/deftest
 elisp-koans/cl-structures-make-struct ()
 "Create a basketball structure instance, and then read out the values."
 (let ((player-1 (make-basketball-player
                  :name "larry" :team :celtics :number 33)))
   (should (equal "larry" (basketball-player-name player-1)))
   (should (equal :celtics (basketball-player-team player-1)))
   (should (equal 33 (basketball-player-number player-1)))
   (should (equal 'basketball-player (type-of player-1)))
   (setf (basketball-player-team player-1) :RETIRED)
   (should (equal :RETIRED (basketball-player-team player-1)))))


(cl-defstruct baseball-player name (position :outfield) (team :red-sox))

(elisp-koans/deftest
 elisp-koans/cl-structures-struct-defaults ()
 "Struct fields can have default values and fields without explicit defaults default to nil."
 (let ((player-2 (make-baseball-player)))
   (should (equal :outfield (baseball-player-position player-2)))
   (should (equal :red-sox (baseball-player-team player-2)))
   (should (equal nil (baseball-player-name player-2)))))


(defstruct (american-football-player (:conc-name nfl-guy-)) name position team)

(elisp-koans/deftest
 elisp-koans/cl-structures-abbreviated-access ()
 "The accessor names can get pretty long.  It's possible to specify
a nickname to make code readable with the :conc-name option."
 (let ((player-3 (make-american-football-player
                  :name "Drew Brees" :position :QB :team "Saints")))
   (should (equal :QB (nfl-guy-position player-3)))))


(cl-defstruct (nba-contract (:include basketball-player)) salary start-year end-year)

(elisp-koans/deftest
 test-structure-extension ()
 "Structs can be defined as EXTENSIONS to previous structures.
This form of inheritance allows composition of objects."
 (let ((contract-1 (make-nba-contract
                    :salary 136000000
                    :start-year 2004
                    :end-year 2011
                    :name "Kobe Bryant"
                    :team :LAKERS
                    :number 24)))
   (should (equal 2004 (nba-contract-start-year contract-1)))
   (should (equal 'nba-contract (type-of contract-1)))
   ;; do inherited structures follow the rules of type hierarchy?
   (should (eq t (typep contract-1 'basketball-player)))
   ;; can you access structure fields with the inherited accessors?
   (should (equal :LAKERS (nba-contract-team contract-1)))
   (should (equal :LAKERS (basketball-player-team contract-1)))))
