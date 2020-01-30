run once "test.ks".
run once "lib.ks".


assert(getPitchForVector(ship:up:forevector), 90, " up is always up.").
 // not precise when ship is holding still since ship might oscillate in the wind, it is a tiny value in a random direction.
print ship:velocity:surface.
print ship:groundspeed.
assert(getPitchForVector(v(0,0,0)), 0, " zero is always zero.").