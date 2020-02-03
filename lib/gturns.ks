@lazyglobal off.

// until ship:apoapsis > desired_altitude
function gturn_velocity {
	local velocity_divisor is 150. // every 150 m/s
	local gt_degrees is 5. // turn 5 degrees	
	local vel_ratio to ship:velocity:surface:mag / velocity_divisor.
	local pitch is (90 - (vel_ratio * gt_degrees)).
	return heading(90, max(0, pitch)).
}

// until ship:altitude > desired_altitude
function gturn_log {
	parameter desiredAltitude, desiredApoapsis.
	until ship:apoapsis > desiredApoapsis {
		local pitch is (1 - ( ship:apoapsis / desiredAltitude )^constant:e) * 90.
		lock steering to  heading(90, max(0, pitch)).
	}
}