(import javax.vecmath.*)
(import edu.ohiou.labimp.gtk3d.*)
(import edu.ohiou.labimp.basis.*)
(import edu.ohiou.implanner.solid.*)

;profile to draw gears
(defglobal ?*prof* = (new Prof2d))

;Draw gears on the canvas 
; ?cx : center of gear x co-ord
; ?cy : center of gear y co-ord
; ?r  : radius of the gear
(deffunction draw-gear (?cx ?cy ?r)
	"Draw gear to the canvas"
    (bind ?g (new Arc2d (new Point2d ?cx ?cy) ?r))
	(?*prof* addCurve ?g) 
)

(deffunction display-gears ()
    ;display gears in applet
(?*prof* settApplet (new Draw2DApplet ?*prof*))
(?*prof* display)
)