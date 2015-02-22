(deftemplate automobile
    	"Template for a specific car"
    	(slot make)
    	(slot model)
    	(slot year (type INTEGER))
    	(slot color (default white)))


(assert (automobile (model LeBaron) (make Chrysler)
        (year 1997)))



(deffacts cars
    "Unordered facts"
    (automobile (make Honda) (model Avenger) (year 2002) (color blue))
    (automobile (make Dodge) (model Dart) (year 2004)))

(deffacts people
 "Ordered Facts"
    (person "Bob" male 35)
    (person "Lisa" female 20))

"
Jess, the Rule Engine for the Java Platform
Copyright (C) 2008 Sandia Corporation
Jess Version 7.1p2 11/5/2008

Jess> (deftemplate automobile
    	"Template for a specific car"
    	(slot make)
    	(slot model)
    	(slot year (type INTEGER))
    	(slot color (default white)))
TRUE
Jess>  (reset)
TRUE
Jess>  (assert (automobile (model LeBaron) (make Chrysler)
        (year 1997)))
<Fact-1>
Jess>  (fact)
Jess reported an error in routine Funcall.execute
	while executing (fact).
  Message: Undefined function fact.
  Program text: ( fact )  at line 10.
Jess>  (facts)
f-0   (MAIN::initial-fact)
f-1   (MAIN::automobile (make Chrysler) (model LeBaron) (year 1997) (color white))
For a total of 2 facts in module MAIN.
Jess> (retract 1)
TRUE
Jess>  (assert (automobile (model LeBaron) (make Chrysler)
        (year 1997)))
<Fact-2>
Jess>  (facts)
f-0   (MAIN::initial-fact)
f-2   (MAIN::automobile (make Chrysler) (model LeBaron) (year 1997) (color white))
For a total of 2 facts in module MAIN.
Jess> (modify 2 (color blue))
<Fact-2>
Jess>  (facts)
f-0   (MAIN::initial-fact)
f-2   (MAIN::automobile (make Chrysler) (model LeBaron) (year 1997) (color blue))
For a total of 2 facts in module MAIN.
Jess> (bind ?c1 (assert (automobile (model LeBaron) (make Chrysler)
        (year 1997))))
<Fact-3>
Jess>  (modify ?c1 (model Shakila))
<Fact-3>
Jess>  (facts)
f-0   (MAIN::initial-fact)
f-2   (MAIN::automobile (make Chrysler) (model LeBaron) (year 1997) (color blue))
f-3   (MAIN::automobile (make Chrysler) (model Shakila) (year 1997) (color white))
For a total of 3 facts in module MAIN.
Jess> (bind ?c1 (assert (automobile (model LeBaron) (make Chrysler)


))
)
<Fact-4>
Jess> (facts)
f-0   (MAIN::initial-fact)
f-2   (MAIN::automobile (make Chrysler) (model LeBaron) (year 1997) (color blue))
f-3   (MAIN::automobile (make Chrysler) (model Shakila) (year 1997) (color white))
f-4   (MAIN::automobile (make Chrysler) (model LeBaron) (year nil) (color white))
For a total of 4 facts in module MAIN.
Jess> (?c2 <- ?c1)
Jess reported an error in routine Context.getVariable
	while executing (call ?c2 <- ?c1).
  Message: No such variable c2.
  Program text: ( ?c2 <- ?c1 )  at line 28.
Jess> (?c2 <- 4)
Jess reported an error in routine Context.getVariable
	while executing (call ?c2 <- 4).
  Message: No such variable c2.
  Program text: ( ?c2 <- 4 )  at line 29.
Jess> (bind ?c2 4)
4
Jess>  (?c2 <-5)
Jess reported an error in routine call
	while executing (call ?c2 <-5).
  Message: No method named '<-5' found in class java.lang.Integer.
  Program text: ( ?c2 <-5 )  at line 31.
Jess> (batch ".\src\WorkingMemoryTutorial.clp")"