class_name Target

extends Node

var owner_entity : BaseEntity
var in_range : Array[BaseEntity]

#var ready_bools := [false]
#var keep_current_targets := true
var current_targets : Array[BaseEntity]

enum target_type {CLOSEST,TARGETSELF,LOWESTHEALTH}

var find_functions = {
	target_type.CLOSEST :  
		Callable(self,"find_condition").bind(
			(func(a, b):(owner_entity.global_position - a.global_position).length() < (owner_entity.global_position - b.global_position).length())),
			
	target_type.LOWESTHEALTH: 
		Callable(self,"find_condition").bind(
			(func(a, b): a.stats.current_health > b.stats.current_health)),
			
	target_type.TARGETSELF: 
		Callable(self,"find_caster")
}

func targets_ready() -> bool:
	return true

func flush_current_targets():
	current_targets = []

func find(target_type_ids : Array[target_type], target_ammounts : Array[int]):
	#later its probably gonna check if current targets are valid still something like that
	flush_current_targets()
	if in_range == []:
		return
	for i in target_type_ids:
		var ammount = target_ammounts.pop_front()
		find_functions[i].call(ammount)
		

#only lambda function changes
func find_condition(ammount : int, custom_func : Callable):
	print("call")
	var target_list = in_range.duplicate()
	target_list.sort_custom(custom_func)
	while ammount > 0:
		current_targets.append(target_list.pop_back())
		ammount -=1
	#targets_ready.append(false)

func find_caster(ammount):
	current_targets.append(owner_entity)
	#targets_ready.append(true)

func find_first_entered():
	pass

func find_last_entered():
	pass

func find_random():
	pass
