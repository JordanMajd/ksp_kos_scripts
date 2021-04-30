// Flies rocket up to 500 meters and hovers
// When fuel is low then proceeds to land

run once "countdown".
initCountDown().

clearScreen.
set _throttle to 0.
lock throttle to _throttle.
lock steering to heading(90, 90).

set landingTime to time:seconds.
set targetAlt to 500.
set startAlt to alt:radar.
set kP to 0.1.
// total error should mean less than current error.
set kI to 0.0001.
set kD to 0.5. 

set hoverPID to pidLoop(kP, kI, kD, 0, 1).
set hoverPID:setpoint to targetAlt.

// get off ground
stats().

stage.
until stage:liquidfuel < 280 {
	set _throttle to + hoverPID:update(time:seconds, ship:altitude).
	stats().
	wait 0.
}

// slam altutide
set targetAlt to 110.
set landingTime to time:seconds.
until alt:radar < (startAlt + 0.5) {
	set _throttle to + hoverPID:update(time:seconds, ship:altitude).
	set hoverPID:setpoint to targetAlt - ((time:seconds - landingTime) * 2).
	set gear to alt:radar < 80.
	stats().
	wait 0.
}
set _throttle to 0.

function stats {
	print "=PID=" at(0, 0).
	print "P: " + hoverPID:pterm at(0, 1).
	print "I: " + hoverPID:iterm at(0, 2).
	print "D: " + hoverPID:dterm at(0, 3).
	print "E: " + hoverPID:error at(0, 4).
	print "O: " + hoverPID:output at(0, 5).
	print "SP: " + hoverPID:setpoint	at (0,6).

	print "=Landing=" at(0, 8).
	print "Time: " + (time:seconds - landingTime) at(0, 9).
	print "Radar Alt: " + alt:radar at(0, 10).
	print "Start Alt: " + startAlt at(0, 11).
	print "Cur Alt: " + ship:altitude at(0, 12).
}