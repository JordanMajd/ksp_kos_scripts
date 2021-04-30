@lazyglobal off.
clearScreen.
// prototyping a Hohman transfer orbit

// Assumptions: circular orbit, no inclination

// 1. Objective is to intercept the other body 180 degrees from where we eject.
// 2. To do this we need to calculate:
//    - Phase angle (y1) the angular relationship between the bodies at departure.
// 3. Time of transfer angle? 
// 4. Ejection angle?


// Notes on wrong transfer:
// y1 is the phase angle at departure
// v2 - v1, the difference of true anomaly, gives us the sweep angle from departure to arrival
// ωt is the angular velocity of the target
// ωt(t2 - t1) is the angle the target will move through while the vessel is en route
// Correct phase angle for departure can be calculated as: y1 = (v2 - v1) - ωt(t2 - t1)

// a1 semi major axis of origin
// a2 semi major axis of target
// (a1 - a2) / 2 semi major axis of transfer


// set v1 to kerbin:orbit:trueanomaly.
// set v2 to duna:orbit:trueanomaly.


// "w" is easier to type than omega "ω"
// velocity will not give us accurate results for eccentric orbits since velocity will change
// set wt to duna:orbit:velocity.

// set y1 to (v2 - v1) - (wt * ()).
// set y1 to (v2 - v1) - wtt2t1.
// set y360  to y1 * 360.
// get degrees
// print("y1: " + y1).
// print("y1 * 360: " + y360).

// calculate angle the target will move through while th


// Hohmann Transfer Ejection Angle
// T = 2 * Pi * sqrt (a^3 / GM) orbital period of transfer
// Simplified, dropping GM we ned up with a^(2/3)
// we only care about half the orbital period since transfer burn is half elipsis a3 / 2
// divide the transfer orbit time with the orbital period of the target body.
// simplify (a1 / a2 +1)^(3/2) / (4*sqrt(2)) to get the offset between the planets, multiply by 360 for deg
function getTransferPhaseAngle {
  parameter originStr, targetStr.
  local origin to body(originStr).
  local target to body(targetStr).
  local a1 to origin:orbit:semimajoraxis.
  local a2 to target:orbit:semimajoraxis.
  // set wtt2t1 to (a1 / a2 + 1)^(1.5) / (4 * sqrt(2)).
  // return  180 - (360 * wtt2t1).
  return 180 * (1 - ((a1 + a2) / (2 * a2)) ^ 1.5).
}

function getCurrentPhaseAngle {
  parameter originStr, targetStr.
  local origin is body(originStr).
  local target is body(targetStr).
  local kerbol is body("sun").
  // BA * BC = COS( || BA || BC )theta
  // theta = (BA * BC ) / (|| BA || || BC ||)
  local distBA is kerbol:position - origin:position.
  local distBC is kerbol:position - target:position.
  return arcCos((distBA * distBC) / (distBA:mag * distBC:mag)).
}


// r = parking orbit radius
// v = ejection velocity
// μ = gravitational parameter of origin plane
function getEjectionAngle {
  parameter originStr.
  parameter altitude.
  local origin is body(originStr).

  local r is origin:radius + altitude.
  local mu is origin:mu.
  local v is getEjectionVelocity(originStr, targetStr, altitude).
  local epsilon is (v^2 / 2)  - (mu / r).
  local h is r * v.
  local e is sqrt(1 + (2 * epsilon * h^2) / mu^2).
  return 180 - arcCos(1 / e).
}


function getCurrentEjectionAngle {
  // direction
  return ship:facing.
}


// v1 = SQRT(  v2^2 + 2*μ/r1 - μ/r2 ) 
// r1 = parking orbit radius
// r2 = SOI radius
// v1 = ejection velocity
// v2 = SOI exit velocity (absolute value)
// vesc = escape velocity taking SOI into consideration

// we only compute our velocity from parking orbit to exit SOI
// due to conservation of momentum
function getEjectionVelocity {
  parameter originStr.
  parameter targetStr.
  parameter altitude.
  local origin is body(originStr).
  local target is body(targetStr).
  local r1 is origin:radius + altitude.
  local r2 is origin:soiradius.
  local mu is origin:mu.
  local v2 is getChangeVelocity(originStr, targetStr, altitude).
  local v1 is sqrt( v2^2 + 2 * mu / r1 - mu / r2).
  return v1.
}

//  Math.sqrt(p.mu / exitAlt) * (Math.sqrt((2 * d.alt) / (exitAlt + d.alt)) - 1);
function getChangeVelocity {
  parameter originStr.
  parameter targetStr.
  parameter altitude.
  local origin is body(originStr).
  local target is body(targetStr).
  // local r1 is (origin:orbit:semimajoraxis + origin:orbit:semiminoraxis) / 2.
  // local r2 is (target:orbit:semimajoraxis + target:orbit:semiminoraxis) / 2.
  local mu is body("sun"):mu.
  local r1 is (origin:orbit:periapsis + origin:orbit:apoapsis) / 2 + origin:soiradius.
  local r2 is (target:orbit:periapsis + target:orbit:apoapsis) / 2.
  local v2 is sqrt(mu / r1) * (sqrt((2 * r2) / (r1 + r2)) - 1).
  return v2.
}
function getDV {
  parameter originStr, altitude, velocity.
  local mu is body(originStr):mu.
  local r1 is body(originStr):radius + altitude.
  return velocity - sqrt(mu / r1).
}

local originStr is "kerbin".
local targetStr is "jool".
local altitude is 100000.

Print("Hohmann transfer params from " + originStr + " to " + targetStr).
print("Current Phase Angle: " + getCurrentPhaseAngle(originStr,targetStr)).
print("Current Ejection Angle:" + getCurrentEjectionAngle()).
print("Transfer Phase Angle: " + getTransferPhaseAngle(originStr, targetStr)).
print("Transfer Ejection Angle: " + getEjectionAngle(originStr, altitude)).
local ej is getEjectionVelocity(originStr, targetStr, altitude).
local dv is getDV(originStr, altitude, ej).
print("Transfer Ejection Velocity: " + ej).
print("Transfer Burn Velocity (dv): " + dv).

