local progName is "launch".
local bootLoader is "boot_launch".
local requirements is list("gturns", "lib").

wait 3.
if(homeConnection:isconnected){
	switch to 0.
	run once bundle.ks.
	bundle(progName, requirements, bootloader).
	switch to 1.
}
// reboot required if bootloader updated