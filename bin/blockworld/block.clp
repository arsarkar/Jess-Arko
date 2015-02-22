(deftemplate ontop 
    	(slot top)
    	(slot bottom))

(deftemplate goal
    	(slot upper)
    	(slot lower)
    	)

(deftemplate block
    	(slot blockName)
    	(slot flag)
    	(slot target )
    	(slot next)) "possible flags: toMove target next free notfree"


(deftemplate move
    	(slot blockname)
    	(slot target)
    	(slot next))



(defrule block-to-place-on-table
    "this rule will select a block from goal which should be placed on the table"
    ?p <- (goal (upper ?u) (lower table))
    	  (ontop (top ?u) (bottom ?b))
    	=>
    	(printout t "block " ?u " is selected to be placed on table" crlf)
    	(assert (block (blockName ?u) (flag target)(next ?u)))    	
    	(printout t crlf))


"main loop: each iteration places one goal block in place"
(defrule check-if-blocked
    "if the target block is not free, flag the upper block as not free"
    ?p <- (block (blockName ?b) (flag target) (next ?n))
    (ontop (top ?t) (bottom ?b))
    =>
    /*   
    (printout t "block " ?b " is found to be blocked by block " ?t ", which is made as notfree" crlf)
    (assert (block (blockName ?t) (flag notfree)))
    */
    (printout t "block " ?t " is made the blocking block" crlf)
    (assert (block (blockName ?b) (flag blocking) (target ?b) (next ?n)))
    (printout t crlf))


"inner loop: move through stack and clear all blocking and move the goal block"

"if the target block is free to move, then hoorray just move"
( defrule find-top
    "find the block which is notfree and try to remove it "
    ?p <- (block ( blockName ?bottom ) (flag blocking) (target ?o)(next ?n))
    ( not ( ontop ( top ?top) ( bottom ?bottom )))
    => 
    (printout t "block " ?bottom " is found to be free to move" crlf)
    (retract ?p)
    (assert (move (blockname ?bottom) (target ?o) (next ?n)))
    (printout t crlf))

(defrule move-to-place
    "if the block to be moved is in the goal place them where they need to be"
    ?p <- (move (blockname ?u)(target ?t)(next ?n))
    ?q <- (block (blockName ?u) (flag target))
    ?s <- (goal (upper ?u) (lower ?l))
    ?r <- (ontop (top ?u) (bottom ?b))
    =>
    (printout t "Moving block " ?u " on top of " ?l crlf)
    (retract ?p)
    (retract ?q)
    (retract ?r)
    (retract ?s)
    (assert (ontop (top ?u) (bottom ?l)))
    (printout t "Making block " ?n " as the next block to select next goal block" crlf)
    (assert (block (blockName ?n) (flag next)))
    (printout t crlf))


(defrule move-to-clear
    "if the block to be moved is not in the goal place just clear them"
    ?p <- (move (blockname ?u)(target ?t)(next ?n))
    (not (block (blockName ?u) (flag target)))
    ?r <- (ontop (top ?u) (bottom ?b))
    =>
    (printout t "Clearing block " ?u crlf)
    (retract ?p)
    (retract ?r)
    (assert (ontop (top ?u) (bottom table)))
    (printout t "Making block " ?t " as the blocking block" crlf)
    (assert (block (blockName ?t) (flag blocking)(target ?t)(next ?n)))
    (printout t crlf))

(defrule find-not-top
    "recursively find the blocking block blocking the block set as blocking"
    ?p <- (block (blockName ?bottom) (flag blocking)(target ?o)(next ?n))
    (ontop (top ?top) (bottom ?bottom))
    => 
    (printout t "block " ?top " is made the blocking block" crlf)
	(modify ?p (blockName ?top))
    (printout t crlf))


(defrule check-if-free
	"if the target block is free to move then move it"
    ?p <- (block (blockName ?b) (flag target)(target ?o)(next ?n))
    (not (ontop (top ?t) (bottom ?b)))
    => 
    (printout t "block " ?b " is free to place to the right spot" crlf)
    (assert (move (blockname ?b)(target ?o)(next ?n)))
    (printout t crlf))

":end inner loop"

(defrule block-to-place-next
    "this rule will slect all subsequent blocks to be placed on top of the goal block on the table"
	?p <- (block (blockName ?b) (flag next))
    	  (goal (upper ?u) (lower ?b))
    =>
	(printout t "block " ?u " is selected to be placed on table" crlf)
    (assert (block (blockName ?u) (flag target) (next ?u)))    	
    (printout t crlf))

":end outer loop"

