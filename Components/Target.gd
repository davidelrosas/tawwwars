class_name Target

extends Node

var current : Object
var in_range : Array[Object] 

#maybe check that in_range isn't empty
#might only be needed if exited area happens more often than shooting
func is_in_range(target : Object,caster : BaseEntity) -> bool:
	if in_range.has(target):
		return true
	else:
		return false

func find_closest(caster : BaseEntity) -> BaseEntity:
	if in_range != []:
		var acc
		for i in in_range:
			if acc == null:
				acc = in_range[0]
			else:
				if caster.appearence.global_position - i.appearence.global_position < caster.appearence.global_position - acc.appearence.global_position:
					acc = i
		return acc
	else:
		return null
