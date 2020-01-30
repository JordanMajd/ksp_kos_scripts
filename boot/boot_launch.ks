parameter progName is "launch", bootLoader is "boot_launch", requirements is list("gturns", "stages", "countdown").

wait 2.
if(homeConnection:isconnected){
	switch to 0.
	run once bundle.ks.
	bundle(progName, requirements, bootloader).
	switch to 1.
}
run launch.
// reboot required if bootloader updated
// TODO detect if previous bootloader different than current and auto reboot.