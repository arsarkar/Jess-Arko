
(batch "./src/blockworld/block.clp")
		
(deffacts blocks
    (ontop (top A) (bottom table))
    (ontop (top B) (bottom table))
    (ontop (top C) (bottom table))
    (goal (upper A) (lower B))
    (goal (upper B) (lower C))
    (goal (upper C) (lower table))
    )

(facts)

(reset)

(run)

(facts)