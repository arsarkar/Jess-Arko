

;function to get user input from console
(deffunction get-input ()
	"get user input from console"
	(bind ?s (read))
    (return ?s)
    )

;function to create first and last gear with configuration entered by user
(deffunction create-facts ()
;Create first gear"
(printout t "enter radius of first gear:" crlf)
(bind ?rf (get-input))
(printout t "enter X Position of first gear:" crlf)
(bind ?xf (get-input))
(printout t "enter Y Position of first gear:" crlf)
(bind ?yf (get-input))
(printout t "enter ang. velocity of first gear:" crlf)
(bind ?vf (get-input))
(printout t "enter direction of rotation of first gear (CW/CCW):" crlf)
(bind ?df (get-input))
(assert (gear (radius ?rf) (xPosition ?xf) (yPosition ?yf) (velocity ?vf) (direction CW) (type FIRST)))
    
;create last gear"
(printout t "enter X Position of second gear:" crlf)
(bind ?xf (get-input))
(printout t "enter Y Position of second gear:" crlf)
(bind ?yf (get-input))
(printout t "enter ang. velocity of second gear:" crlf)
(bind ?vf (get-input))
(printout t "enter direction of rotation of second gear (CW/CCW):" crlf)
(bind ?df (get-input))
(assert (gear (xPosition ?xf) (yPosition ?yf) (velocity ?vf) (direction CW) (type LAST)))
    
;set maximum radius of intermediate gears
(printout t "enter maximum radius allowed for intermediate gears:" crlf)
(bind ?*max-diam* (* (get-input) 2))
(printout t "max radius for intermediate gears is set to :" ?*max-diam* crlf)
(printout t "enter minimum radius allowed for intermediate gears:" crlf)
(bind ?*min-diam* (* (get-input) 2))
(printout t "min radius for intermediate gears is set to :" ?*min-diam* crlf)               
)


(deffunction get-gear-count (?nl ?ds)
	"Calculate total number of gears needed"
	(if (= ?ds 0) then
        (bind ?n ?nl)
     else
        (bind ?n (+ ?nl 1)))
    return ?n
 )


(deffunction get-direction (?dir)
	"returns the direction of current gear based on last gear's rotation"
	(if (= ?dir "CW") then
        (bind ?nd "CCW")
      else
        (bind ?nd "CW"))
    return ?nd)