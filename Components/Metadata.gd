class_name Metadata

var displayname : StringName
var description : String
var cost : float
var icon : CompressedTexture2D
var scene : PackedScene
var classification : Classification

enum Classification {
	Support = 0,
	Offense = 1,
	Defense = 2
}

@warning_ignore("shadowed_variable")
func _init(displayname : StringName, classification : Classification, description : String, cost : float, icon : CompressedTexture2D, scene : PackedScene):
	self.displayname = displayname
	self.description = description
	self.cost = cost
	self.icon = icon
	self.scene = scene
	self.classification = classification
