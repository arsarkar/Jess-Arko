(import edu.ohiou.labimp.gtk3d.*)
(import edu.ohiou.labimp.draw.*)
(import edu.ohiou.labimp.basis.*)
(import java.awt.Color)
(import javax.vecmath.*)


(bind ?line1 (new Line2d 0 0 100 100))
(bind ?line2 (new Line2d 0 50 100 50))
(bind ?p (?line1 intersect ?line2))

; printiing point mem location
(printout t "point as seen in jess: " ?p crlf)

; printing point data
(printout t "point: " (?p toString) crlf)



;create an arc like a circle
(bind ?c1 (new Arc2d (new Point2d 0 0) 2))

(?c1 settColor (Color red))

(bind ?prof (new Prof2d))

(?prof addCurve ?c1)

;set WFApplet
(?prof settApplet (new Draw2DApplet ?prof))

;display
(?prof display)