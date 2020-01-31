// stuff taht doesn't have a place to live yet.

function getPitchForVector {
	parameter in.
	return 90 - vectorAngle(ship:up:forevector, in).
}