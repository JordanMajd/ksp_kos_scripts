# KOS

## Files

## Equations

drag
FD = 0.5 p * v^2 * d * A
p = atmospherig density (kg / m^3)
v = ship velocity (m / s)
d = coefficient of drag
A = cross-sectional area (m2)

Terminal velocity indicates the optimal ascending speed.
FG = m * a = (m * GM) / r^2


## Resources



## Comments

// TODO when in space blow fairing and open electric

// what about just burning every time apoapsis orbital speed goes below target speed until periapsis orbital speed is below target speed?

// if eta:apoapsis < burnTime or eta:apoapsis > eta:periapsis { // worksish!
// if orbitalSpeed(ship:apoapsis) > targetSpeed {  // good maintenence but not good for circularizing
// TODO might need to ensure peri speed is positive

	// local burnTime is 36. // between 34 38
	// if eta:apoapsis < burnTime or eta:apoapsis > eta:periapsis {

When transitioning from a gravity turn into raising my periapsis do I burn parallel to the planets surface (`heading(90, 0).` or prograde to circularize?

in my latest launch script what i did was move away from circulizing at a fixed altitude and just target a circular orbit.
to do this i lock to prograde and then calculate the difference between my velocity and the velocity needed for a circular orbit at AP then i just use throttle to keep the duration of the burn and the ETA to AP the same

by targeting a ETA smaller than the duration of the burn you should be able to keep a higher throttle i use eta =  burn duration because that gives me more margin for if i need to do staging

tends to be with in a few 100m of the target AP

should be possible to improve it with some additional pitch logic to keep the AP rising but that mostly felt like to much work for to little gain, might do it at some point but not now

## TODO

- Save config for what operations have occured or haven't occured.


