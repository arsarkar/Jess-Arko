
(deffunction change-diaper()
    	(printout t "the baby is clean now" crlf))

(defrule change-baby-if-wet
    "If baby is wet, change its diaper."
    ?wet <- (baby-is-wet)
    =>
    (change-diaper)
    (retract ?wet))

