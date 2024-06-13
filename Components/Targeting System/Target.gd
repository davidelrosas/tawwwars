class_name Target

var owner_entity : BaseEntity

var in_range : Array[BaseEntity]
#var allies_in_range : Array[BaseEntity]
#var enemies_in_range : Array[BaseEntity]

#var ready_bools := [false]
#var keep_current_targets := true
var current_targets : Array[BaseEntity]

enum target_type {CLOSEST,TARGETSELF,LOWESTHEALTH}

#region DETECTION LOGIC
func connect_det_range():
	owner_entity.det_area.entity_entered_range.connect(_store_entity)
	owner_entity.det_area.entity_exited_range.connect(_delete_entity)

func _store_entity(entity : BaseEntity):
	if entity != owner_entity:
		in_range.append(entity)

func _delete_entity(entity : BaseEntity):
	if in_range.has(entity):
		in_range.erase(entity)
		if current_targets.has(entity):
			current_targets.erase(entity)
			#and here probably run the Target function targets_ready(): again
			#or also if a target Dies inside the detection range, we should connect to
			# the death signal

#endregion

#region FIND FUNCTIONS
var find_functions = {
	target_type.CLOSEST: 
		find_condition.bind(
			(func(a, b):(a.global_position - owner_entity.global_position).length_squared() < (b.global_position - owner_entity.global_position).length_squared())),
			
	target_type.LOWESTHEALTH: 
		find_condition.bind(
			(func(a, b): a.stats.current_health > b.stats.current_health)),
			
	target_type.TARGETSELF: 
		Callable(self,"find_caster")
}

func targets_ready() -> bool:
	return true

func flush_current_targets():
	current_targets = []

func find(target_type_ids : Array[target_type], target_amounts : Array[int]):
	#later its probably gonna check if current targets are valid still something like that
	flush_current_targets()
	if in_range == []:
		return
	for i in target_type_ids:
		var amount = target_amounts.pop_front()
		find_functions[i].call(amount)
	remove_duplicates(current_targets)

func remove_duplicates(list : Array):
	var unique = []
	for item in list:
		if not unique.has(item):
			unique.append(item)
	list = unique

func find_condition(amount : int, sort_func : Callable):
	var target_list = in_range.duplicate()
	target_list.sort_custom(sort_func)
	while amount > 0 && target_list.size() > 0:
		current_targets.append(target_list.pop_back())
		amount -=1
	#targets_ready.append(false)

func find_caster(_amount):
	current_targets.append(owner_entity)
	#targets_ready.append(true)

func find_first_entered():
	pass

func find_last_entered():
	pass

func find_random():
	pass
#endregion
