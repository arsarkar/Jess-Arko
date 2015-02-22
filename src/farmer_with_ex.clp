; ISE 709 Intelligent Engineering Systems Spring 2006/07
;
; file farmer-with_ex.clp, final solution for farmer problem in Jess
;
;
; Uses template and fact exclude to store which move is to be excluded
; 	from reasoning, logic implemented is that whenever we make a move we exclude
; 	it for next step of reasoning eg. if we move farmer and wolf, in the next step
; 	we exclude that move from reasoning.
; This also helps generate the end of moves when everybody is on the other
; 	side of river
;
; The rules from farmer-rule.clp file are modified to consider exclude fact in
; 	the reasoning and to modify its slots directing rule execution to avoid back moves
; 	and to avoid moving everybody back at the end
;
; Sample execution is added to the end of the file
;
; Copyright D N Sormaz 2000

;;;;;;;;;;;;;;;;;;;;;;;;;;;; DEFINITION OF TEMPLATES

(deftemplate state
    (slot farmer-loc )   ; farmer location
    (slot wolf-loc )       ; wolf location
    (slot goat-loc )       ; goat location
    (slot cabbage-loc)) ; cabbage location

(deftemplate exclude
    
    (slot object)     ; object to be excluded
    )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;  DEFINITION OF HELPER FUNCTIONS

(deffunction print-object (?s)
    (return (str-cat "State: farmer " (fact-slot-value ?s farmer-loc)
            ", wolf " (fact-slot-value ?s wolf-loc )
            ", goat "(fact-slot-value ?s goat-loc )
            ", cabbage "(fact-slot-value ?s cabbage-loc) "."))
    )

(deffunction change-loc (?loc)
    (not ?loc)
    )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;  DEFINITION OF RULES
(defrule move-farmer
    ?s <- (state  (farmer-loc ?fl) (wolf-loc ?wl) (goat-loc ?gl&~?wl&~?cl) (cabbage-loc ?cl))
    ?e <- (exclude)
    (not (exclude (object farmer)))
    =>
    (printout t "old state: " (print-object ?s) crlf)
    (printout t "move farmer"  crlf)
    (bind ?new-loc (change-loc ?fl) )
    (modify ?e (object farmer))
    (modify ?s  (farmer-loc ?new-loc))
    (printout t "new state: " (print-object ?s) crlf crlf)
    )



(defrule move-farmer-wolf
    ?s <- (state  (farmer-loc ?fl) (wolf-loc ?fl) (goat-loc ?gl)
        (cabbage-loc ?cl&~?gl))
    ?e <- (exclude)
    (not (exclude (object wolf)))
    =>
    (printout t "old state:" (print-object ?s) crlf)
    (printout t "move farmer and wolf"  crlf)
    (bind ?new-loc (change-loc ?fl) )
    (modify  ?e (object wolf))
    (modify ?s  (farmer-loc ?new-loc) (wolf-loc ?new-loc))
    (printout t "new state: " (print-object ?s) crlf crlf )
    )

(defrule move-farmer-goat
    ?s <- (state  (farmer-loc ?fl) (wolf-loc ?wl) (goat-loc ?fl) )
    ?e <- (exclude)
    (not (exclude (object goat)))
    =>
    (printout t "old state: " (print-object ?s) crlf)
    (printout t "move farmer and goat"  crlf)
    (bind ?new-loc (change-loc ?fl) )
    (modify  ?e (object goat))
    (modify ?s  (farmer-loc ?new-loc) (goat-loc ?new-loc))
    (printout t "new state: " (print-object ?s) crlf crlf)
    )

(defrule move-farmer-cabbage
    ?s <- (state  (farmer-loc ?fl) (wolf-loc ?wl) (goat-loc ?gl&~?wl)
        (cabbage-loc ?fl))
    ?e <- (exclude)
    (not (exclude (object cabbage)))
    =>
    (printout t "old state: " (print-object ?s) crlf)
    (printout t "move farmer and cabbage"  crlf)
    (bind ?new-loc (change-loc ?fl) )
    (modify  ?e (object cabbage))
    (modify ?s  (farmer-loc ?new-loc) (cabbage-loc ?new-loc))
    (printout t "new state: " (print-object ?s) crlf crlf)
    )

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; CREATION OF DATA BASE AND EXECUTION
; general test from the start
(defrule initialize
    
    =>
    (printout t "enter initial location(TRUE or FALSE):")
    (bind ?il (read))
    ( assert (state (farmer-loc ?il) (wolf-loc ?il) (goat-loc ?il) (cabbage-loc ?il)))
    (assert (exclude))
    )


(reset)

(run)   ; allows the progrma to run directly when the file is batched into Jess





;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; SAMPLE EXECUTION OF THE PROGRAM
/*


Jess, the Rule Engine for the Java Platform
Copyright (C) 2006 Sandia Corporation
Jess Version 7.0RC1 9/5/2006

enter initial location(TRUE or FALSE):TRUE
old state: State: farmer TRUE, wolf TRUE, goat TRUE, cabbage TRUE.
move farmer and goat
new state: State: farmer FALSE, wolf TRUE, goat FALSE, cabbage TRUE.

old state: State: farmer FALSE, wolf TRUE, goat FALSE, cabbage TRUE.
move farmer
new state: State: farmer TRUE, wolf TRUE, goat FALSE, cabbage TRUE.

old state:State: farmer TRUE, wolf TRUE, goat FALSE, cabbage TRUE.
move farmer and wolf
new state: State: farmer FALSE, wolf FALSE, goat FALSE, cabbage TRUE.

old state: State: farmer FALSE, wolf FALSE, goat FALSE, cabbage TRUE.
move farmer and goat
new state: State: farmer TRUE, wolf FALSE, goat TRUE, cabbage TRUE.

old state: State: farmer TRUE, wolf FALSE, goat TRUE, cabbage TRUE.
move farmer and cabbage
new state: State: farmer FALSE, wolf FALSE, goat TRUE, cabbage FALSE.

old state: State: farmer FALSE, wolf FALSE, goat TRUE, cabbage FALSE.
move farmer
new state: State: farmer TRUE, wolf FALSE, goat TRUE, cabbage FALSE.

old state: State: farmer TRUE, wolf FALSE, goat TRUE, cabbage FALSE.
move farmer and goat
new state: State: farmer FALSE, wolf FALSE, goat FALSE, cabbage FALSE.

*/
