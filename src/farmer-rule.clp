; ISE 709 Intelligent Engineering Systems Spriong 06/07
;
; file farmer-rule.clp, initial solution for farmer problem in Jess
;
; introduces template state where we store the current state of the problem
; a rule is defined for each possible move: farmer alone, farmer and wolf, 
;      farmer and goat, farmer and cabbage
; few helper functions are defined to manage location changes and state report
; user enters initial location using initialize rule
; does not prevent infinite loop, because the same move (move back)
; 		may be repeated.
;
; sample execution is added to the end of the file
;
; Copyright D N Sormaz 2000

;;;;;;;;;;;;;;;;;;;;;;;;;;;; DEFINITION OF TEMPLATES
(deftemplate state
    (slot farmer-loc )   ; farmer location
    (slot wolf-loc )       ; wolf location
    (slot goat-loc )       ; goat location
    (slot cabbage-loc)) ; cabbage location

;;;;;;;;;;;;;;;;;;;;;;;;;;;;  DEFINITION OF HELPER FUNCTIONS

(deffunction change-loc (?loc)
    (not ?loc)
    )

(deffunction print-object (?s)
    (return (str-cat "State: farmer " (fact-slot-value ?s farmer-loc)
            ", wolf " (fact-slot-value ?s wolf-loc )
            ", goat "(fact-slot-value ?s goat-loc )
            ", cabbage "(fact-slot-value ?s cabbage-loc) "."))
    )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  DEFINITION OF RULES
(defrule move-farmer
    ?s <- (state  (farmer-loc ?fl) (wolf-loc ?wl) 
        			(goat-loc ?gl&~?wl&~?cl) (cabbage-loc ?cl))
    =>
    (printout t "old state: " (print-object ?s) crlf)
    (printout t "move farmer"  crlf)
    (bind ?new-loc (change-loc ?fl) )
    (modify ?s  (farmer-loc ?new-loc))
    (printout t "new state: " (print-object ?s) crlf crlf)
    )

(defrule move-farmer-wolf
    ?s <- (state  (farmer-loc ?fl) (wolf-loc ?fl) (goat-loc ?gl)
        			(cabbage-loc ?cl&~?gl))
    =>
    (printout t "old state:" (print-object ?s) crlf)
    (printout t "move farmer and wolf"  crlf)
    (bind ?new-loc (change-loc ?fl) )
    (modify ?s  (farmer-loc ?new-loc) (wolf-loc ?new-loc))
    (printout t "new state: " (print-object ?s) crlf crlf )
    )





(defrule move-farmer-goat
    ?s <- (state  (farmer-loc ?fl) (wolf-loc ?wl) (goat-loc ?fl) )
    =>
    (printout t "old state: " (print-object ?s) crlf)
    (printout t "move farmer and goat"  crlf)
    (bind ?new-loc (change-loc ?fl) )
    (modify ?s  (farmer-loc ?new-loc) (goat-loc ?new-loc))
    (printout t "new state: " (print-object ?s) crlf crlf)
    )

(defrule move-farmer-cabbage
    ?s <- (state  (farmer-loc ?fl) (wolf-loc ?wl) (goat-loc ?gl&~?wl)
        			(cabbage-loc ?fl))
    =>
    (printout t "old state: " (print-object ?s) crlf)
    (printout t "move farmer and cabbage"  crlf)
    (bind ?new-loc (change-loc ?fl) )
    (modify ?s  (farmer-loc ?new-loc) (cabbage-loc ?new-loc))
    (printout t "new state: " (print-object ?s) crlf crlf)
    )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; CREATION OF DATA BASE AND EXECUTION
; general test from the start

(defrule initialize
    
    =>
    (printout t "enter initial location(TRUE or FALSE):")
    (bind ?il (read))
    ( assert (state (farmer-loc ?il) (wolf-loc ?il) 
            		(goat-loc ?il) (cabbage-loc ?il)))
    )

(reset)   	; used to reset the rule engine, advised in order 
			; to clear any previous execution (rules, facts)

(run)   run is commented out beacuse it goes into a infinite loop
;(run 6) this has been executed from the Jess prompt
























;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; SAMPLE EXECUTION OF THE PROGRAM
/*

Jess, the Rule Engine for the Java Platform
Copyright (C) 2006 Sandia Corporation
Jess Version 7.0RC1 9/5/2006

Jess> (batch farmer-rule.clp)
TRUE
Jess> (run 6)
enter initial location(TRUE or FALSE):TRUE
old state: State: farmer TRUE, wolf TRUE, goat TRUE, cabbage TRUE.
move farmer and goat
new state: State: farmer FALSE, wolf TRUE, goat FALSE, cabbage TRUE.

old state: State: farmer FALSE, wolf TRUE, goat FALSE, cabbage TRUE.
move farmer
new state: State: farmer TRUE, wolf TRUE, goat FALSE, cabbage TRUE.

old state: State: farmer TRUE, wolf TRUE, goat FALSE, cabbage TRUE.
move farmer and cabbage
new state: State: farmer FALSE, wolf TRUE, goat FALSE, cabbage FALSE.

old state: State: farmer FALSE, wolf TRUE, goat FALSE, cabbage FALSE.
move farmer and goat
new state: State: farmer TRUE, wolf TRUE, goat TRUE, cabbage FALSE.

old state: State: farmer TRUE, wolf TRUE, goat TRUE, cabbage FALSE.
move farmer and goat
new state: State: farmer FALSE, wolf TRUE, goat FALSE, cabbage FALSE.

6
Jess> 

*/
