// stuff someone posts 

function getPitchForVector {
	parameter in.
	return 90 - vectorAngle(ship:up:forevector, in).
}

// whoops forgot that SHIP:Q is also in atm so the conversion was not needed
FUNCTION current_mach_number {
	LOCAL currentPresure IS MAX(BODY:ATM:ALTITUDEPRESSURE(SHIP:ALTITUDE),0.0000001).
	RETURN SQRT(2 / BODY:ATM:ADIABATICINDEX * SHIP:Q / currentPresure).
}


// the temp you can access is not the true atmospheric temp
// that is only the base atmoserpic temp curve that is further modified by several other factors and curves
function mach_number {
    parameter velocitymag is velocity:surface:mag.
    parameter temp is body:atm:alttemp(ship:altitude).
    parameter molarmass is body:atm:molarmass.
    parameter gamma is body:atm:adbidx.

    local speed_of_sound is sqrt(gamma * constant:IdealGas * temp / molarmass).
    return velocitymag / speed_of_sound.
}

// If i have the math right the way you get the current temperature with out measuring it in kOS is something like this. 
LOCAL specificGas IS CONSTANT:IDEALGAS/BODY:ATM:MOLARMASS.
LOCAL atmDencity IS (SHIP:Q * CONSTANT:ATMTOKPA * 2) / (SHIP:VELOCITY:SURFACE:SQRMAGNITUDE).
LOCAL atmPressure IS MAX(BODY:ATM:ALTITUDEPRESSURE(newAlt),0.0000001) * CONSTANT:ATMTOKPA.
LOCAL atmTemp IS atmPressure / (specificGas * atmDencity).


// circularize direction stabilized?
SET steerLock TO UP:VECTOR - (SHIP:VELOCITY:SURFACE:NORMALIZED / 10)


// drag calculations
LOCAL preVel IS SHIP:VELOCITY:SURFACE.
LOCAL preTime IS TIME:SECONDS.
LOCAL preGravVec IS localBody:POSITION - SHIP:POSITION.
LOCAL preForeVec IS SHIP:FACING:FOREVECTOR.
LOCAL preMass IS SHIP:MASS.

LOCAL gg0 IS CONSTANT:g0.
RCS OFF.
UNTIL RCS {
    WAIT 0.

    LOCAL newTime IS TIME:SECONDS.
    LOCAL newVel IS SHIP:VELOCITY:SURFACE.
    LOCAL newMass IS SHIP:MASS.
    LOCAL newForeVec IS SHIP:FACING:FOREVECTOR.
    LOCAL newGravVec IS localBody:POSITION - SHIP:POSITION.
    LOCAL avrForeVec IS ((newForeVec + preForeVec) / 2):NORMALIZED.

    LOCAL deltaTime IS newTime - preTime.
    LOCAL gravVec IS average_grav(preGravVec:MAG,newGravVec:MAG) * (newGravVec:NORMALIZED + preGravVec:NORMALIZED):NORMALIZED * deltaTime.
    
    LOCAL burnDV IS shipISP * gg0 * LN(preMass / newMass) * burnCoeff.
    LOCAL accelVec IS avrForeVec * burnDV.
    
    LOCAL dragAcc IS (newVel - (preVel + gravVec + accelVec)) / deltaTime.
    LOCAL dragForce IS ((newMass + preMass) / 2) * VDOT(dragAcc,avrForeVec).

    SET preVel TO newVel.
    SET preTime TO newTime.
    SET preGravVec TO newGravVec.
    SET preForeVec TO newForeVec.
    SET preMass TO newMass.
}

FUNCTION average_grav {
    PARAMETER rad1 IS SHIP:ALTITUDE,rad2 IS 0, localBody IS SHIP:BODY.
    IF rad1 > rad2 {
        RETURN ((localBody:MU / rad2) - (localBody:MU / rad1))/(rad1 - rad2).
    } ELSE IF rad2 > rad1 {
        RETURN ((localBody:MU / rad1) - (localBody:MU / rad2))/(rad2 - rad1).
    } ELSE {
        RETURN localBody:MU / rad1^2.
    }
}


// eccentricity pid loop
set apo_PID to PIDLoop(0.25, 0.02, 0.005, 0, 1). // parameters. YMMV here.
lock trgtETA to (body:atm:height * 0.001) * orbit:eccentricity. // I use the height of the atmosphere because I sometimes launch from other planets or moons.
lock throttle to trgtThrottle.
lock steering to vxcl(up:vector, prograde:vector). // Locks the steering to prograde with 0 pitch.

until periapsis > altitude * 0.99 {
  set apo_PID:setpoint to trgtETA. // target value.
  set trgtThrottle to apo_PID:update(time:seconds, eta:apoapsis).
}