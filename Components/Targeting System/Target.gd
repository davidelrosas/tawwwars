class_name Target

extends Node

var owner_entity : BaseEntity
var in_range : Array[BaseEntity]

#var ready_bools := [false]
#var keep_current_targets := true
var current_targets : Array[BaseEntity]

enum target_type {CLOSEST,TARGETSELF,LOWESTHEALTH}

var functions = {
	target_type.CLOSEST :  Callable(self,"find_closest"),
	target_type.TARGETSELF: Callable(self,"find_caster"),
	target_type.LOWESTHEALTH: Callable(self,"find_lowest_health")
}

func targets_ready() -> bool:
	return true

func find(target_type_ids : Array[target_type], target_ammounts : Array[int]):
	current_targets = []
	print(target_ammounts)
	for i in target_type_ids:
		var ammount = target_ammounts.pop_front()
		print(ammount)
		functions[i].bind(ammount).call()

func find_caster():
	current_targets.append(owner_entity)
	#targets_ready.append(true)

func find_first_entered():
	pass

func find_last_entered():
	pass

func find_random():
	pass

#only lambda function changes
func find_closest(ammount):
	var target_list = in_range
	target_list.sort_custom((func(a, b): 
		(owner_entity.global_position - a.global_position) < (owner_entity.global_position - b.global_position)))
	while ammount > 0:
		current_targets.append(target_list.pop_back())
		ammount -=1
	#targets_ready.append(false)

#between these two so probably bind the lambda function in the dictionary
func find_lowest_health(ammount):
	var target_list = in_range
	target_list.sort_custom((func(a, b): a.current_health > b.current_health))
	while ammount > 0:
		current_targets.append(target_list.pop_back())
		ammount -=1
	#targets_ready.append(false)

func multi_find_closest() -> Array[BaseEntity]:
	return []

func multi_find_lowest_health() -> Array[BaseEntity]:
	return []
