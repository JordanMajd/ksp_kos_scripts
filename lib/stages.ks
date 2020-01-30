@lazyglobal off.

local numStages is stage:number.
global lock stageCount to numStages - stage:number.

function initAutoStage {
	parameter maxAutoStages is numStages.
	when maxthrust = 0 then {
		stage.
		if stageCount < maxAutoStages {
			return true. // keep checking
		}
	}
}

function getStageCount {
	return stageCount.
}
