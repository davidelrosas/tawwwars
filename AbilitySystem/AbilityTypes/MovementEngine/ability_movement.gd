class_name AbilityMovement

extends Node

var ability : Ability
var target : BaseEntity
var speed : float
var direction : Vector2

func set_properties(speed : float, direction : Vector2, target : BaseEntity, ability : Ability):
	self.speed = speed
	self.direction = direction
	self.target = target
	self.ability = ability
