(deftemplate person (slot height) 
	(slot age)
    (slot fname)
    (slot lname)
    (slot look)
    )

(defrule young-people
    ?p  <- (person (age ?a) (fname ?n))
    (test (< ?a 30))
    =>
    (modify ?p (look young))
    (printout t "person " ?n " is young" crlf)
    )

(defrule old-people
    ?p  <- (person (fname ?n) (age ?a&:(> ?a 40)))

    =>
    (modify ?p (look old))
    (printout t "person " ?n " is old" crlf)
    )

(defrule check-look
    (person (look young))
    =>
    (printout t "const rule young person" crlf)
    )

(defrule check-look-var
    (person (look ?young))
    (test (eq ?young young))
    =>
    (printout t "var rule young person" crlf)
    )

(deffacts people
     (person (fname dusan) (age 58)
        )
     (person (fname mayur)(age 23))
    )
    

(reset)

(run)