class_name Target

extends Node

var current : BaseEntity
var in_range : Array[BaseEntity] 

var single_target : BaseEntity
var multi_target : Array[BaseEntity]

enum target_type {CLOSEST}

var dict = {
	target_type.CLOSEST :  "maybe a function?, create a couple see whats needed"
}

func find(target_type_id : target_type, caster):
	match target_type_id:
		target_type.CLOSEST:
			var single_target = find_closest(caster)
	
func find_closest(caster : BaseEntity) -> BaseEntity:
	var acc = null
	for i in in_range:
		if acc == null || caster.global_position - i.global_position < caster.global_position - acc.global_position:
			acc = i
	return acc

func find_lowest_health() -> BaseEntity:
	var acc = null
	for i in in_range:
		if acc == null || i.healthbar.value < acc.healthbar.value:
			acc = i
	return acc
