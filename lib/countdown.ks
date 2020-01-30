@lazyglobal off.

function initCountDown {
	parameter duration is 10.
	print "Press any key to cancel countdown...".
	from {local count is duration.} until count = 0 step {set count to count - 1.} do {
		print count.
		if terminal:input:haschar {
			set exit to 0/0.
		}
		wait 1.
	}
}
