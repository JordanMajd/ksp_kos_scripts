// Test loader
wait 2. // wait on secene load

copyPath("0:/lib/lib.ks", "").
copyPath("0:/lib/lib.test.ks", "").
copyPath("0:/src/test.ks", "").

run "lib.test.ks".