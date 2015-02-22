
(batch "./src/blockworld/block.clp")
		
(deffacts blocks
    (ontop (top B) (bottom A))
    (ontop (top A) (bottom table))
    (ontop (top C) (bottom table))
    (ontop (top D) (bottom table))
    (goal (upper C) (lower A))
    (goal (upper A) (lower table))
    (goal (upper B) (lower D))
    (goal (upper D) (lower table))
    )

(facts)

(reset)

(run)

(facts)