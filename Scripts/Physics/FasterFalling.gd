extends RigidBody2D

export(float, 0, 10) var fall_scale := 1.2;

var original_gravity_scale: float;

func _ready():
	original_gravity_scale = gravity_scale;


func _physics_process(delta):
	if linear_velocity.dot(get_gravity()) > 0:
		gravity_scale = original_gravity_scale * fall_scale;
	
	else:
		gravity_scale = original_gravity_scale;
	
	
func get_gravity() -> Vector2:
	return ProjectSettings.get_setting("physics/2d/default_gravity_vector");
