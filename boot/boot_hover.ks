parameter progName is "hover",
	bootLoader is "boot_hover",
	requirements is list("countdown", "lib"),
	compile is false,
	clean is false.

wait 1.
if homeConnection:isconnected {
	switch to 0.
	run once bundle.ks.
	bundle(progName, requirements, bootloader, compile, clean).
	switch to 1.
}

// 1231 comment to have diff file size

run once "lib".
setConfigValue("autolaunch", true).

// otherwise user can type run hover in terminal
local autoLaunch is getConfigValue("autolaunch").
if autoLaunch = true {
	run hover.
}