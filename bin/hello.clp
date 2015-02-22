(deftemplate person (slot height)
    	(slot age)
    	(slot lname)
    	(slot look))

(deffacts people
(person (height 6)
    	(age 10)
    	(lname kong)
    	(look young))
)


(defrule young-people 
    	?p <- (person (age ?a))
    	(test (< ?a 12))
    => (modify ?p (look young)))

(defrule check-young 
    	(person (look young))
    	=>
    	(printout t "young person"))
(reset)
(run)