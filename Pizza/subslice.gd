
enum Slotflags {Selected = 1, Rest = 2, Towar = 4, Temporary = 8}
var flags : int
var baseColor : Color
var color : Color
var towar : Towar = null

func _init(flags : int, color = Color(0.1,0.1,0.1)):
	self.flags = flags
	baseColor = color
	Timelord.advance_measure.connect(on_measure)

func on_activation(actionbits:int,timing:float)->void:
	baseColor = Color(actionbits&1,actionbits&2,actionbits&4)
	
func on_subbeat()->void:
	color = baseColor.inverted()
	await Timelord.advance_subbeat
	color = baseColor

func on_measure()->void:
	baseColor = Color(0,0,0)
