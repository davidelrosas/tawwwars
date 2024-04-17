extends Action

var max_targets : int

func action(target : Target, caster):
	for i in target.in_range:
		i.target_data.current = caster 
		print("taunt")
	#make it only last for so long
