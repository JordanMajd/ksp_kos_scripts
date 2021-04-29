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

- [Wiki: Terminology](https://wiki.kerbalspaceprogram.com/wiki/Terminology)
- [Wiki: Cheat Sheet](https://wiki.kerbalspaceprogram.com/wiki/Cheat_sheet)
- [Wiki: Gravity Turn](https://wiki.kerbalspaceprogram.com/wiki/Gravity_turn)
- [Wiki: Atmosphere](https://wiki.kerbalspaceprogram.com/wiki/Atmosphere)
- [Wiki: basic Orbiting](https://wiki.kerbalspaceprogram.com/wiki/Tutorial:_Basic_Orbiting_(Math))
- [Wiki: Advanced Orbiting](https://wiki.kerbalspaceprogram.com/wiki/Tutorial:_Advanced_Orbiting)
- [First Point of Aries](https://en.wikipedia.org/wiki/First_Point_of_Aries)
- [Braeunig: Orbital Mechanics](http://www.braeunig.us/space/orbmech.htm)

Burn Time:

- [Tsiolkovsky Rocket Equation](https://en.wikipedia.org/wiki/Tsiolkovsky_rocket_equation)
- [Tsiolkovsky's rocket equation](https://canmom.github.io/physics/rocket-equation#information-staging)
- [Burn Time](https://www.reddit.com/r/Kos/comments/3ftcwk/compute_burn_time_with_calculus/)

### KOS

- [KOS](https://ksp-kos.github.io/KOS/contents.html)
- [KOS: How do I use libs](https://www.reddit.com/r/Kos/comments/43wgoc/how_do_i_use_libraries/)
- [KOS: How do I achieve a more circular orbit](https://www.reddit.com/r/KerbalSpaceProgram/comments/2c2bo5/how_can_i_achieve_a_more_circular_orbit/)
- [KOS: Gradient Descent](https://www.reddit.com/r/Kos/comments/bg7qlz/gradient_descent_is_finding_unusual_solution/)
- [KOS: Visavis](https://www.reddit.com/r/Kos/comments/azr17q/how_can_you_calculate_the_circularisation_burn/)
- [What is the easiest way to circularize](https://www.reddit.com/r/Kos/comments/2wuo9o/what_is_the_easiest_way_to_circularize_while/)

## Comments

// reboot required if bootloader updated
// TODO detect if previous bootloader different than current and auto reboot.

// TODO when in space blow fairing and open electric
// TODO auto start program and have press x to cancel during countdown.

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


