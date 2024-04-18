class_name Target

extends Node

var current : BaseEntity
var in_range : Array[BaseEntity] 

#might only be needed if exited area happens more often than shooting
func is_in_range(target : BaseEntity,caster : BaseEntity) -> bool:
	return in_range.has(target)

func find_closest(caster : BaseEntity) -> BaseEntity:
	var acc = null
	for i in in_range:
		if acc == null || caster.global_position - i.global_position < caster.global_position - acc.global_position:
			acc = i
	return acc
