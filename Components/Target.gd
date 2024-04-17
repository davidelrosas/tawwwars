class_name Target

extends Node

var current : Object
var in_range : Array[Object] 

#might only be needed if exited area happens more often than shooting
func is_in_range(target : Object,caster : BaseEntity) -> bool:
	return in_range.has(target)

func find_closest(caster : BaseEntity) -> BaseEntity:
	var acc = null
	for i in in_range:
		if acc == null || caster.appearence.global_position - i.appearence.global_position < caster.appearence.global_position - acc.appearence.global_position:
				acc = i
	return acc
