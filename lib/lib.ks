@lazyglobal off.

local confPath is "1:/config.json".

function exit {
	setConfigValue("autolaunch", false).
	reboot.
}

function setConfigValue {
	parameter key, value.
	local conf is ensureConfig().
	if conf:haskey(key) {
		set conf[key] to value.
	} else {
		conf:add(key, value).
	}
	writeJson(conf, confPath).
}

function getConfigValue {
	parameter key.
	local conf is ensureConfig().
	if(conf:haskey(key)){
		return conf[key].
	}
}

function ensureConfig {
	if not exists(confPath) {
		local conf is lexicon().
		writeJson(conf, confPath).
		return conf.
	}
	return readJson(confPath).
}
