@lazyglobal off.

// getPitchForVector
//
// @params in: vector
// @returns 
function getPitchForVector {
	parameter in.
	return 90 - vectorAngle(ship:up:forevector, in).
}