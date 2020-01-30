parameter progName is "hover", bootLoader is "boot_hover", requirements is list().

wait 2.
if(homeConnection:isconnected){
	switch to 0.
	run once bundle.ks.
	bundle(progName, requirements, bootloader).
	switch to 1.
}
// reboot required if bootloader updated
// to swap bootloaders runPath("boot/boot_launch", "", "boot_hover").