parameter progName is "hover",
	bootLoader is "boot_hover",
	requirements is list("countdown", "lib"),
	compile is false,
	clean is false..

wait 2.
if(homeConnection:isconnected){
	switch to 0.
	run once bundle.ks.
	if(clean) {
		cleanFiles().
	}
	bundle(progName, requirements, bootloader, compile).
	switch to 1.
}
// reboot required if bootloader updated
// to swap bootloaders runPath("boot/boot_launch", "", "boot_hover").

// if autolaunch run, otherwise user can type run hover in terminal
run once "lib".
// setConfigValue("autolaunch", false).
local autolaunch is getConfigValue("autolaunch").
if autolaunch = "true" {
	run hover.
}