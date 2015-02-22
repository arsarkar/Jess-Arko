;"Template for storing gear information"
;"direction can take values CW or CCW"
;"type can take values FIRST LAST INTERMEDIATE" 
(deftemplate gear 
	(slot radius)         
    (slot xPosition)
	(slot yPosition)
	(slot velocity)
    (slot direction) 
    (slot type)
)

; template for intermedaite gear configuration
(deftemplate int-gears
    (slot fullgear)
    (slot firstshortgear)
    (slot shortgear)
    (slot x1)
    (slot y1)
    (slot r1)    
    (slot d1)
    (slot x2)
    (slot y2)
    (slot r2)
    (slot d2)
)

;template for short gear configuration
(deftemplate short-gear
    (slot x1)
    (slot y1)
    (slot r1)
    (slot d1)
    (slot x2)
    (slot y2)
    (slot r2)
    (slot gap)
)

; gap between first and last gears
(deftemplate distance
    (slot dist))