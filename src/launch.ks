// includes
run once "gturns".
run once "stages".
run once "countdown".

clearscreen.

local missionStatus is "prelaunch".
local desiredAltitude is 76000.
local _steering is heading(90, 90).

// lock variables.
lock steering to _steering.
lock throttle to 1.0.

set missionStatus to "countdown".
initCountDown().
initAutoStage().
stats().

set missionStatus to "gturn".
// until ship:apoapsis > desiredAltitude {
until ship:apoapsis > desiredAltitude {
	set _steering to gturn_log(desiredAltitude).
	stats().
}
// after gravity turn cut
lock throttle to 0.

set missionStatus to "circularizing".
until ship:periapsis > desiredAltitude {
	set _steering to heading(90, 0).
	if eta:apoapsis < 30 or eta:periapsis > eta:apoapsis {
			lock throttle to 1.
	} else {
			lock throttle to 0.
	}
	stats().
}

endProgram.

function stats {
	print "Status: " + missionStatus at (0, 0).
	print "Stage: " + getStageCount() at (0, 1).
	print "Vert Speed: " + ship:verticalspeed at (0, 2).
	print "Ground Speed: " + ship:groundspeed  at (0, 3).
	print "Air Speed: " + ship:airspeed at (0, 4).
	print "Apoapsis: " + round(ship:apoapsis, 0) + " (" + round(eta:apoapsis, 0) + "s)" at (0, 5).
	print "Periapsis: " + round(ship:periapsis, 0) + " (" + round(eta:periapsis, 0) + "s)" at (0, 6).
}

function endProgram {
	lock throttle to 0.
	// ensure user throttle resets
	set ship:control:pilotmainthrottle to 0.
	clearscreen.
}


// TODO when in space blow fairing and open electric
// TODO auto start program and have press x to cancel during countdown.