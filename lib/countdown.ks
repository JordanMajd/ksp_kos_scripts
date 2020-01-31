@lazyglobal off.

run once "lib".

function initCountDown {
	parameter duration is 10.
	print "Press any key to cancel countdown...".
	from {local count is duration.} until count = 0 step {set count to count - 1.} do {
		print count.
		if terminal:input:haschar {
			exit().
		}
		wait 1.
	}
}
