@lazyglobal off.

local numStages is stage:number.
global lock stageCount to numStages - stage:number.

function initAutoStage {
	parameter maxAutoStages is numStages.
	local stageStartingSolidFuel is stage:resourcesLex["SolidFuel"]:amount.
	when maxthrust = 0 or (
			stageStartingSolidFuel > 0 and (stageStartingSolidFuel - stage:resourcesLex["SolidFuel"]:amount) = stageStartingSolidFuel
		) then {
		stage.
		if stageCount < maxAutoStages {
			set stageStartingSolidFuel to stage:resourcesLex["SolidFuel"]:amount.
			return true. // keep checking
		}
	}
}

function getStageCount {
	return stageCount.
}
