// includes
run once "gturns".
run once "stages".
run once "countdown".

clearscreen.

local missionStatus is "prelaunch".
local targetAltitude is 71000.
local targetSpeed is orbitalSpeed(targetAltitude).
local _steering is heading(90, 90).

// lock variables.
lock steering to _steering.
lock throttle to 1.0.

set missionStatus to "countdown".
if(ship:altitude < 250){
	initCountDown().
}

initAutoStage().

clearscreen.

set missionStatus to "gturn".
until ship:apoapsis > targetAltitude {
	set _steering to gturn_log(targetAltitude).
	stats().
}
// after gravity turn cut
lock throttle to 0.

// blow fairings and open panels
when ship:altitude > 55000 then toggle ag1.

local burnTime is 45. // TODO compute

set missionStatus to "circularizing".
until orbitalSpeed(ship:periapsis) < targetSpeed {
	set _steering to heading(90, 0).
	if eta:apoapsis < burnTime or eta:apoapsis > eta:periapsis {
		lock throttle to 1.
	} else {
		lock throttle to 0.
	}
	stats().
}

endProgram.

// Vis-viva for circular orbit.
// For non circular orbit need to replace body:radius with semimajoraxis.
function orbitalSpeed {
	parameter tAlt.
	return sqrt(body:mu / (tAlt + body:radius)).
} 

function stats {
	print "Status: " + missionStatus at (0, 0).
	print "Stage: " + getStageCount() at (0, 1).
	print "Vert Speed: " + ship:verticalspeed at (0, 2).
	print "Ground Speed: " + ship:groundspeed  at (0, 3).
	print "Air Speed: " + ship:airspeed at (0, 4).

	//altitude
	print "Apoapsis: " + round(ship:apoapsis, 0) + " (" + round(eta:apoapsis, 0) + "s)" at (0, 5).
	print "Periapsis: " + round(ship:periapsis, 0) + " (" + round(eta:periapsis, 0) + "s)" at (0, 6).
	
	print "Target Orb Speed: " + round(targetSpeed, 0) at (0, 7).
	print "Orb Speed: " + round(ship:velocity:orbit:mag, 0) at (0, 8).
	print "Apo Orb Speed: " + round(ship:apoapsis, 0) at (0, 9).
	print "Peri Orb Speed: " + round(ship:periapsis, 0) at (0, 10).
}

function endProgram {
	lock throttle to 0.
	// ensure user throttle resets
	set ship:control:pilotmainthrottle to 0.
	clearscreen.
}


// TODO when in space blow fairing and open electric
// TODO auto start program and have press x to cancel during countdown.

// what about just burning every time apoapsis orbital speed goes below target speed until periapsis orbital speed is below target speed?