local binPath is "bin/".
local bootPath is "boot/".
local srcPath is "src/".
local libPath is "lib/".
local outPath is "1:/".

function bundle {
	parameter program, requirements, bootLoader, compile is false.

	// copy bootloader first so it can update itself regardless of if there are bugs later on.
	copyFile(bootLoader, bootPath, true, compile).
	copyFile(program, srcPath, false, compile).

	for lib in requirements {
		copyFile(lib, libPath, false, compile).
	}
}

function copyFile {
	parameter name, path, boot is false, compile is false.

	if name = "" return.

	if compile {
		return compileCopy(name, path, boot).
	}

	setBootfileName(name, ".ks", boot).
	return copyPath(path + name, choose outPath + bootPath if boot else outPath).
}

function compileCopy {
	parameter name, path, boot is false.

	local outName is name + ".ksm".
	compile path + name  to binPath + outName.

	setBootfileName(name, ".ksm", boot).
	return copyPath(binPath + name, choose outPath + bootPath if boot else outPath).
}

function setBootfileName {
	parameter name, ext, boot.
	if boot {
		set core:bootfilename to bootPath + name + ext.
	}
}
