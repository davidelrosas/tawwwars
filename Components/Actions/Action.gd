class_name Action

enum action_list{SIMPLESHOT, AREAHEAL}

const script_paths = {
	action_list.SIMPLESHOT : "res://Components/Actions/SimpleShotAction.gd",
	action_list.AREAHEAL : "res://Components/Actions/AreaHealAction.gd"
}


func action(target : Target,caster):
	pass
