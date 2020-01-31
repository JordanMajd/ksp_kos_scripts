parameter progName is "launch",
	bootLoader is "boot_launch",
	requirements is list("gturns", "stages", "countdown", "lib"),
	compile is true.

wait 1. // wait for connection.
if(homeConnection:isconnected){
	switch to 0.
	run once bundle.ks.
	clean().
	bundle(progName, requirements, bootloader, compile).
	switch to 1.
}

run once lib.
local autolaunch is getConfigValue("autolaunch").
if autolaunch = "true" {
	run launch.
}

// reboot required if bootloader updated
// TODO detect if previous bootloader different than current and auto reboot.
// TODO clean.