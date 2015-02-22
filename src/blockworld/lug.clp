(batch "./src/blockworld/block.clp")
		
(deffacts blocks
    (ontop (top B) (bottom A))
    (ontop (top A) (bottom table))
    (ontop (top C) (bottom table))
    (ontop (top E) (bottom D))
    (ontop (top D) (bottom table))
	(goal (upper B) (lower A))
    (goal (upper A) (lower C))
    (goal (upper C) (lower table))
    (goal (upper E) (lower D))
    (goal (upper D) (lower table))    
    )

(facts)

(reset)

(run)

(facts)