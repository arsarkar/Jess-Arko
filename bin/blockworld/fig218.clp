(batch "./src/blockworld/block.clp")
		
(deffacts blocks
    (ontop (top X) (bottom table))
    (ontop (top B) (bottom E))
    (ontop (top E) (bottom A))
    (ontop (top A) (bottom T))
    (ontop (top T) (bottom table))
    (ontop (top L) (bottom Q))
    (ontop (top Q) (bottom table))
    (ontop (top S) (bottom R))
    (ontop (top R) (bottom table))
    (ontop (top J) (bottom table))
    (goal (upper T) (lower A))
    (goal (upper A) (lower B))
    (goal (upper B) (lower L))
    (goal (upper L) (lower E))
    (goal (upper E) (lower table))
    )

(facts)

(reset)

(run)

(facts)