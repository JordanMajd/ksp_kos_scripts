// includes
run once "gturns".

clearscreen.

local mission_status is "prelaunch".
local desired_altitude is 76000.
local _steering is heading(90, 90).
local stage_count is 0.

// lock variables.
lock steering to _steering.
lock throttle to 1.0.

set mission_status to "countdown".
from {local cd is 3.} until cd = 0 step {set cd to cd - 1.} do {
	print cd.
	wait 1.
}

stats().

// autostaging
when maxthrust = 0 then {
	wait 0.5. // staging can take longer than 0.5
	stage.
	set stage_count to stage_count + 1.
	if stage_count < 6 {
			return true. // keep checking
	}
}

set mission_status to "gturn".
// until ship:apoapsis > desired_altitude {
until ship:apoapsis > desired_altitude {
	set _steering to gturn_log(desired_altitude).
	stats().
}
// after gravity turn cut
lock throttle to 0.

set mission_status to "circularizing".
until ship:periapsis > desired_altitude {
	set _steering to heading(90, 0).
	if eta:apoapsis < 30 or eta:periapsis < eta:apoapsis {
			lock throttle to 1.
	} else {
			lock throttle to 0.
	}
	stats().
}

endProgram.

function stats {
	clearscreen.
	print "Status: " + mission_status at (0, 0).
	print "Stage: " + stage_count at (0, 1).
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