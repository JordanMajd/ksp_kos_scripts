@lazyglobal off.

run once "lib".

function initCountDown {
	parameter duration is 10.
	print "Press key to cancel.".
	from {local count is duration.} until count = 0 step {set count to count - 1.} do {
		print count.
		if terminal:input:haschar {
			exit().
		}
		wait 1.
	}
}

function circl {
	LOCK THROTTLE TO throt.
	UNTIL done {//assumes only a single stage is needed for circularization
			LOCAL circVel IS SQRT(BODY:MU / (SHIP:ORBIT:APOAPSIS + BODY:RADIUS)).
			LOCAL burnDv IS circVel - SHIP:VELOCITY:ORBIT:MAG.
			LOCAL etaAP IS signed_eta_ap().
			LOCAL burnDuration IS burn_duration(currentISP,burnDv).
			SET circThrottlePID:SETPOINT TO burnDuration + 1.
			SET throt TO circThrottlePID:UPDATE(TIME:SECONDS,etaAP).
			WAIT 0.
			IF ABS(burnDv) < 0.1 {
					SET done TO TRUE.
			}
	}
}
