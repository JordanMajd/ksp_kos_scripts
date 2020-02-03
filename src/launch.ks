run once "gturns".
run once "stages".
run once "countdown".

local _throttle is 1.
local targetAltitude is body:atm:height * 1.005. //1.005
local targetGTurnApo is targetAltitude * 0.8.
local targetSpeed is visviva(targetAltitude, true).

// lock variables.
lock steering to heading(90, 90).
lock throttle to _throttle.

initCountDown(3).
initAutoStage().
gturn_log(targetGTurnApo, targetAltitude).

lock steering to vectorExclude(up:vector, prograde:vector).
set _throttle to 0.

when ship:altitude > targetGTurnApo then toggle ag1.
// when ship:periapsis > body:atm:height then {
// 	set _throttle to 0.
// 	wait 0.5.
// 	stage.
// }

clearScreen.

// when eccentricity is 0 we are circular.
// compute what eta to apoapsis should be.
// should be 0 when we arecircular.
local cirPID is pidLoop(0.1, 0.005,  0.5, 0, 1).
until ship:periapsis > targetAltitude {
	set cirPID:setpoint to targetAltitude * 0.001 * orbit:eccentricity.
	set _throttle to cirPid:update(time:seconds, eta:apoapsis).
	print "Target Alt:" + targetAltitude at (0, 0).
	print "SP: " + cirPID:setpoint at (0,1).
	print "Ecc:" + orbit:eccentricity at (0,2).
}

lock throttle to 0.
set ship:control:pilotmainthrottle to 0.
clearscreen.

function visviva {
	parameter tAlt, circle is false.
	local a is orbit:semiMajorAxis.
	local r is tAlt + body:radius.
	if(circle){
		set a to r.
	}
	return sqrt(body:mu * ((2 / r) - (1 / a))).
}

// g turn till apo high enough
// push peri to in orbit with pidCir.
// hammon till peri and apo desired height
// pidcir on each side