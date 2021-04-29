@lazyglobal off.

local vesselConfigPath is path("1:/vessel_config.json").
local globalConfigPath is path("0:/global_config.json").

function exit {
	setConfigValue("autolaunch", false).
	reboot.
}

function setConfigValue {
	parameter key, value, useGlobal is false.
	local conf is ensureConfig(useGlobal).
	if conf:haskey(key) {
		set conf[key] to value.
	} else {
		conf:add(key, value).
	}
	writeJson(conf, getConfigPath(useGlobal)).
}

function getConfigValue {
	parameter key, useGlobal is false.
	local conf is ensureConfig(useGlobal).
	if(conf:haskey(key)){
		return conf[key].
	}
}

function ensureConfig {
	parameter useGlobal is false.
	local confPath is getConfigPath(useGlobal).
	if not exists(confPath) {
		local conf is lexicon().
		writeJson(conf, confPath).
		return conf.
	}
	return readJson(confPath).
}

function getConfigPath {
	parameter useGlobal is false.
	if useGlobal {
		return globalConfigPath.
	} else {
		return vesselConfigPath.
	}
}
