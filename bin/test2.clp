(defrule multiple-variable
       ?p <- (Ana ?x) 
    	?t <- (Toby ?x) 
    => 
    (printout t "found fact " (call ?p getName) ?p ?t crlf))

(assert (Ana 23) (Ana 34) (Toby 34) (Toby 23))

(run)
