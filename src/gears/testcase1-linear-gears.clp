(batch "./src/gears/gear-rules.clp")

(deffacts gears 
    (gear (radius 12) (xPosition 10) (yPosition 10) (velocity 16) (direction CW) (type FIRST))
    (gear (xPosition 50) (yPosition 50) (velocity 50) (direction CW)(type LAST)))


(reset)
(facts)
(watch all)
(run)

(display-gears)

(facts)