(deftemplate thing
    	(slot name) 
    	(slot type))

(deftemplate person 
			(slot alive)
        	(slot name))

(deftemplate likes
    	(slot name)
    	(slot item))

(deftemplate eats
    	(slot name)
    	(slot item))

(deffacts foods
    	(thing (name apple) 
        		(type food))
    	(thing (name chicken) 
        		(type food))
    	(thing (name peanut) 
        		(type nil))
    	(eats (name Ben)
        		(item peanuts))
    	(person (name John))
    	(person (name Ben)
        	(alive TRUE)))

(defrule john-likes-all-food 
    (person (name John))
    (thing (name ?n) (type food))
    =>
    (assert (likes (name John) (item ?n)))
    (facts)
    	)

(defrule ben-eats-sue-eats
    	(eats (name Ben) (item ?i))
    =>
    (assert (eats (name sue) (item ?i)))  
    )

(defrule anything-eateable-is-food
    ?t <- (thing (name ?n))
    (eats (name ?p) (item ?n))
    (person (name ?p) (alive TRUE))
    =>
  ;  (assert (thing (name ?n) (type food)))
    (modify ?t (type food))
    )
(reset)
(facts)

(printout t "executing")
(run)









