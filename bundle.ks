@lazyglobal off.

local binPath is "bin/".
local bootPath is "boot/".
local srcPath is "src/".
local libPath is "lib/".
local outPath is "1:/".

function bundle {
	parameter program, requirements, bootLoader, compile is false, clean is false.

	local bootFileSize is getBootloaderSize().

	// make sure to clean after getting boot loader size
	if clean {
		cleanFiles().
	}

	// copy bootloader to vessel, if file size is different reboot to run latest
	copyFile(bootLoader, bootPath, true, compile).
	local newBootFileSize is getBootloaderSize().
	if bootFileSize <> newBootFileSize {
		reboot.
	}

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

function cleanFiles {
	parameter cleanPath is path(outPath).
	for file in listFiles(cleanPath):values() {
		if file:extension = "ks" or file:extension = ("ksm") {
			deletePath(outPath + file:name).
		}
	}
}

// listPath can be string or path()
// return -1 if not found
// TODO why isn't volumedirectory:list an iterable list but a lexicon?
function listFiles {
	parameter listPath is path().
	// convert string to path
	set listPath to path(listPath).

	local currentVolumeItem is listPath:volume:files.
	for seg in listPath:segments {

		if currentVolumeItem:typename = "VolumeDirectory" {
			set currentVolumeItem to currentVolumeItem:list.
		}

		if currentVolumeItem:haskey(seg) {
			set currentVolumeItem to currentVolumeItem[seg].
		} else { // not found
			return -1.
		}
	}

	if currentVolumeItem:hassuffix("list") {
		return currentVolumeItem:list.
	}
	return currentVolumeItem.
}

function getBootloaderSize {
	local bp is path("1:/boot").
	local bootLoader is bp:volume:open(core:bootfilename).
	return bootloader:size.
}