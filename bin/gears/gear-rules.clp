(batch "./src/gears/gear-templates.clp")
(batch "./src/gears/gear-functions.clp")
(batch "./src/gears/gear-drawing.clp")

;defglobal maximum and minimum diameter for gears allowed
(defglobal ?*max-diam* = 15) 
(defglobal ?*min-diam* = 10)


;create first and last gears from user input
;(create-facts)

;Calculate the radius of the second gear to complete initial configuration
;the radius of the second gear is calculated to get the desired angualar velocity
(defrule design-last-gear
    ?l <- (gear (type LAST))
    ?f <- (gear (type FIRST))
    =>		
    (draw-gear ?f.xPosition ?f.yPosition ?f.radius)	
    (bind ?rl (/ (* ?f.radius ?f.velocity) ?l.velocity))
    (modify ?l (radius ?rl))
    (draw-gear ?l.xPosition ?l.yPosition ?rl)
    (bind ?d ((new Point2d ?l.xPosition ?l.yPosition) distance (new Point2d ?f.xPosition ?f.yPosition)))
    (assert (distance (dist (- (- ?d ?f.radius) ?rl))))
    )

;if second gear radius is too big
; distance between them cannot be less than 0
(defrule detect-collision
    (distance {dist < 0})
    =>
    (printout t "The gear is not possible to design, because the second gear is too big to fit in the mentioned position to generate the desired angular velocity")
    )

; if the first gear and the second gear is touching each other (distance = 0) but they need to turn in the same direction then the gear arrangement is not possible
(defrule no-intermediate-gear
    (distance {dist == 0})
    (gear (direction ?dl)(type LAST))
    (gear (direction ?df)(type FIRST))
    (eq ?dl ?df)
    =>
    (printout t "The gear is not possible to design, because first and second gear needs to move in same direction and there is no space for an intermediate gear")
    )


; get the initial configuration of the gear train
(defrule configure-odd-gear-train
    ?d <- (distance (dist ?dist&:(> ?dist 0)))
    ?f<-(gear (type FIRST)(direction ?df))
    ?l<-(gear (type LAST)(direction ?dl))
    (test (and (eq ?df ?dl) (oddp (get-gear-count (div ?dist ?*max-diam*) (- ?dist (* (div ?dist ?*max-diam*) ?*max-diam*))))))
    =>
    (assert (int-gears (fullgear (div ?dist ?*max-diam*)) (firstshortgear 0) (shortgear (- ?dist (* (div ?dist ?*max-diam*) ?*max-diam*))) (x1 ?f.xPosition) (y1 ?f.yPosition) (x2 ?l.xPosition) (y2 ?l.yPosition) (r1 ?f.radius) (r2 ?l.radius) (d1 ?f.direction) (d2 ?l.direction)))        
)

(defrule configure-even-gear-train
    ?d <- (distance (dist ?dist&:(> ?dist 0)))
    ?f<-(gear (type FIRST)(direction ?df))
    ?l<-(gear (type LAST)(direction ?dl))
    (test (not(and (eq ?df ?dl) (oddp (get-gear-count (div ?dist ?*max-diam*) (- ?dist (* (div ?dist ?*max-diam*) ?*max-diam*)))))))
    =>
    ( assert ( int-gears (fullgear (div ?dist ?*max-diam*)) ( firstshortgear (/ (- ?dist (* (div ?dist ?*max-diam*) ?*max-diam*)) 2))( shortgear ( / (- ?dist (* (div ?dist ?*max-diam*) ?*max-diam*)) 2 )) (x1 ?f.xPosition ) (y1 ?f.yPosition ) (x2 ?l.xPosition ) (y2 ?l.yPosition ) (r1 ?f.radius) ( r2 ?l.radius) ( d1 ?f.direction) ( d2 ?l.direction)))
)    

;Configure large gears with initial position
(defrule configure-large-gear
    ?i<-(int-gears {fullgear > 0})
    =>
    (bind ?l1 (new Line2d (new Point2d ?i.x1 ?i.y1) (new Point2d ?i.x2 ?i.y2)))
    (bind ?factor (+ ?i.r1 ?i.firstshortgear (/ ?*max-diam* 2)))
    (bind ?p1 (?l1 pointOnLine ?factor))
    (assert (gear (radius (/ ?*max-diam* 2)) (xPosition ?p1.x) (yPosition ?p1.y) (direction (get-direction ?i.d1)) (type INTERMEDIATE)))
    (draw-gear ?p1.x ?p1.y (/ ?*max-diam* 2))
    (modify ?i (fullgear (- ?i.fullgear 1)) (firstshortgear 0) (x1 ?p1.x) (y1 ?p1.y) (r1 (/ ?*max-diam* 2))(d1 (get-direction ?i.d1)))
)

(defrule configure-large-gear-with-firstsmall
    ?i<-(int-gears {fullgear > 0}{firstshortgear > 0})
    =>
    (bind ?l1 (new Line2d (new Point2d ?i.x1 ?i.y1) (new Point2d ?i.x2 ?i.y2)))
    (bind ?factor (+ ?i.r1 ?i.firstshortgear (/ ?*max-diam* 2)))
    (bind ?p1 (?l1 pointOnLine ?factor))
    (assert (gear (radius (/ ?*max-diam* 2)) (xPosition ?p1.x) (yPosition ?p1.y) (direction (get-direction ?i.d1)) (type INTERMEDIATE)))
    (draw-gear ?p1.x ?p1.y (/ ?*max-diam* 2))
    (assert (short-gear (x1 ?i.x1) (y1 ?i.y1) (r1 ?i.r1) (x2 ?p1.x) (y2 ?p1.y) (r2 (/ ?*max-diam* 2)) (d1 ?i.d1) (gap ?i.firstshortgear)))       ;create a fact for short gear
    (modify ?i (fullgear (- ?i.fullgear 1)) (firstshortgear 0) (x1 ?p1.x) (y1 ?p1.y) (r1 (/ ?*max-diam* 2))(d1 (get-direction ?i.d1)))
)

;create fact for last short gear when all large gears are built
(defrule configure-last-smallgear
    ?i<-(int-gears {fullgear == 0} {shortgear > 0})
    =>
    (assert (short-gear (x1 ?i.x1) (y1 ?i.y1) (r1 ?i.r1) (x2 ?i.x2) (y2 ?i.y2) (r2 ?i.r2) (d1 ?i.d1)(gap ?i.shortgear))) 
)

(defrule configure-small-gear-linear
    ?i<-(short-gear {gap <= ?*max-diam* && gap >= ?*min-diam*})
    =>
    (bind ?l1 (new Line2d (new Point2d ?i.x1 ?i.y1) (new Point2d ?i.x2 ?i.y2)))
    (bind ?factor (+ ?i.r1 (/ ?i.gap 2)))
    (bind ?p1 (?l1 pointOnLine ?factor))
    (assert (gear (radius (/ ?i.gap 2)) (xPosition ?p1.x) (yPosition ?p1.y) (direction (get-direction ?i.d1)) (type INTERMEDIATE)))
    (draw-gear ?p1.x ?p1.y (/ ?i.gap 2))
    )

(defrule configure-small-gear-nonlinear
    ?i<-(short-gear { gap < ?*min-diam*})
    =>
    (bind ?c1 (new Circle2D ?i.x1 ?i.y1 (+ (/ ?*min-diam* 2) ?i.r1)))
    (bind ?c2 (new Circle2D ?i.x2 ?i.y2 (+ (/ ?*min-diam* 2) ?i.r2)))
    (bind ?p1 (?c1 singleIntersect ?c2))
    (assert (gear (radius (/ ?*min-diam* 2)) (xPosition ?p1.x) (yPosition ?p1.y) (direction (get-direction ?i.d1)) (type INTERMEDIATE)))
    (draw-gear ?p1.x ?p1.y (/ ?*min-diam* 2))
)

