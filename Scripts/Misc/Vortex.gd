extends Sprite

export var effective_distance := 32

var effective_distance_squared: float

func _ready():
	effective_distance_squared = effective_distance * effective_distance
	print(effective_distance)
	
func _physics_process(delta):
	var floor_nodes = get_tree().get_nodes_in_group("FloorNodes");
	
	for node in floor_nodes:
		var to_vortex: Vector2 = self.global_position - node.global_position;
		var len2 = to_vortex.length_squared();
		
		if len2 < effective_distance_squared:
			node.add_follow(global_position);


func _on_AudioStreamPlayer2D_finished():
	$AudioStreamPlayer2D.play()
	pass # Replace with function body.
