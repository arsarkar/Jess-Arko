
(batch "./src/blockworld/block.clp")
		
(deffacts blocks
    (ontop (top C) (bottom A))
    (ontop (top A) (bottom table))
    (ontop (top B) (bottom table))
    (goal (upper A) (lower B))
    (goal (upper B) (lower C))
    (goal (upper C) (lower table))
    )

(facts)

(reset)

(run)

(facts)