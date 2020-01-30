parameter progName is "launch", bootLoader is "boot_launch", requirements is list("gturns").

wait 2.
if(homeConnection:isconnected){
	switch to 0.
	run once bundle.ks.
	bundle(progName, requirements, bootloader).
	switch to 1.
}
// reboot required if bootloader updated