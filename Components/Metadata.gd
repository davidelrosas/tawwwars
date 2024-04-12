class_name Metadata

var displayname : StringName
var description : String
var cost : float
var icon : CompressedTexture2D

func _init(displayname : StringName, description : String, cost : float, icon : CompressedTexture2D):
	self.displayname = displayname
	self.description = description
	self.cost = cost
	self.icon = icon
	
