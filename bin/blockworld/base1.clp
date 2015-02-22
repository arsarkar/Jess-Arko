
(batch "./src/blockworld/block.clp")
		
(deffacts blocks
    (ontop (top A) (bottom B))
    (ontop (top B) (bottom C))
    (ontop (top C) (bottom table))
    (ontop (top D) (bottom E))
    (ontop (top E) (bottom F))
    (ontop (top F) (bottom table))
    (goal (upper C) (lower E))
    (goal (upper E) (lower table))
    )



(reset)


(facts)
(run)

(facts)

