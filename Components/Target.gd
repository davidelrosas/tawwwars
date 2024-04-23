class_name Target

extends Node

var current : BaseEntity
var in_range : Array[BaseEntity] 

func find_closest(caster : BaseEntity) -> BaseEntity:
	var acc = null
	for i in in_range:
		if acc == null || caster.global_position - i.global_position < caster.global_position - acc.global_position:
			acc = i
	return acc
