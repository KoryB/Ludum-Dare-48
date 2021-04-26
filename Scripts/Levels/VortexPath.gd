extends PathFollow2D

export(float, 0, 10) var completion_time := 1.0;
export var effective_distance := 16;

func _ready():
	$Vortex.effective_distance = effective_distance
	pass

func _process(delta):
	unit_offset += delta / completion_time
