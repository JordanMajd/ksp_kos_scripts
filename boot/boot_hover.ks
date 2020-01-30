local progName is "hover".
local bootLoader is "boot_hover".
local requirements is list().

wait 1.
if(homeConnection:isconnected){
	switch to 0.
	run once bundle.ks.
	bundle(progName, requirements, bootloader).
	switch to 1.
}
// reboot required if bootloader updated