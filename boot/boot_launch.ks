parameter progName is "launch",
	bootLoader is "boot_launch",
	requirements is list("gturns", "stages", "countdown", "lib"),
	compile is false,
	clean is false.

wait 1. // wait for connection.
if homeConnection:isconnected {
	switch to 0.
	run once bundle.ks.
	bundle(progName, requirements, bootloader, compile, clean).
	switch to 1.
}

run once "lib".
//setConfigValue("autolaunch", true).
local autolaunch is getConfigValue("autolaunch").
if autolaunch = true {
	run launch.
}
