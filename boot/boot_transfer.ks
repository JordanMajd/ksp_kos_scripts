parameter progName is "transfer",
	bootLoader is "boot_transfer",
	requirements is list(),
	compile is false,
	clean is false.

wait 2.
if homeConnection:isconnected {
	switch to 0.
	run once bundle.ks.
	bundle(progName, requirements, bootloader, compile, clean).
	switch to 1.
}

run once transfer.