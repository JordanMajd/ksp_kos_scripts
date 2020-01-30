local binPath is "bin/".
local bootPath is "boot/".
local srcPath is "src/".
local libPath is "lib/".
local outPath is "1:/".

function bundle {
  parameter program, requirements, bootLoader, compile is false.

  copyFile(program, srcPath, false, compile).
  copyFile(bootLoader, bootPath, true, compile).

  for lib in requirements {
    copyFile(lib, libPath, false, compile).
  }
}

function copyFile {
  parameter name, path, boot is false, compile is false.

  if compile {
    return compileCopy(name, path, boot).
  }

  local out is outPath.
  if boot {
    set out to outPath + bootPath.
    set core:bootFileName to out + name + ".ks".
  }
  return copyPath(path + name, out).
}

function compileCopy {
  parameter name, path, boot is false.

  local outName is name + ".ksm".
  compile path + name  to binPath + outName.
  
  local out is outPath.
  if boot {
    set out to outPath + bootPath.
    set core:bootFileName to out + outName.
  }

  return copyPath(binPath + name, out).
}

// todo keep compiled bootloaders in boot?