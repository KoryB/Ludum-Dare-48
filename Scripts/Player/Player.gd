extends RigidBody2D

export var initial_move_impulse := 10
export var move_force := 200

export var jump_impulse := -100

export var fall_scale := 1.4;

var is_left_down: bool
var is_right_down: bool
var is_jump_down: bool

var is_left_pressed: bool
var is_right_pressed: bool

var is_transitioned := false;

var original_gravity_scale: float;

func _ready():
	set_process_input(true);
	original_gravity_scale = gravity_scale;


func _physics_process(delta):
	if is_left_down:
		add_central_force(Vector2(-move_force, 0));
		
	if is_right_down:
		add_central_force(Vector2(move_force, 0));
		
func _process(delta):
	is_left_pressed = false;
	is_right_pressed = false;
	
	if is_left_down:
		$Sprite.scale.x = 1
	
	if is_right_down:
		$Sprite.scale.x = -1

	var self_rect = $Sprite.get_rect();
	self_rect.position += global_position;
	
	var exit = get_tree().get_root().find_node("Exit", true, false);

	
	if not is_transitioned:
		if exit != null:
			if self_rect.has_point(exit.global_position):
				var transition = get_tree().get_root().find_node("SceneTransitionRect", true, false);
				
				if transition != null:
					is_transitioned = true;
					transition.transition_to()
				
	
	if global_position.y > 1000:
		$Sprite/SFX/SfxVoom.play()
		
	if global_position.y > 1500:
		get_tree().reload_current_scene()

# Godot doesn't do this for some reason: https://github.com/godotengine/godot/issues/38646
func _integrate_forces(state):
	var gravity_dot = linear_velocity.dot(get_gravity());
	
	applied_force *= 0;
	
	if gravity_dot > 0:
		gravity_scale = original_gravity_scale * fall_scale;
		
	else:
		gravity_scale = original_gravity_scale;

	if linear_velocity.y > 200:
		if test_motion(Vector2(0, 2)):
			$Sprite/SFX/SfxLand.play();

func _input(event):
	if event.is_action_pressed("ui_left"):
		is_left_down = true;
		is_left_pressed = true;
		
		stop_horizontal_velocity()
		apply_central_impulse(Vector2(-move_force, 0));
		
			
	if event.is_action_pressed("ui_right"):
		is_right_down = true;
		is_right_pressed = true;
		
		stop_horizontal_velocity()
		apply_central_impulse(Vector2(move_force, 0));
		
		
	if event.is_action_pressed("jump"):
		is_jump_down = true;
		
		if test_motion(Vector2(0, 1)):
			apply_jump_impulse();
				
		
	if event.is_action_released("ui_left"):
		is_left_down = false;
		
		if not is_right_down:
			almost_stop_horizontal_velocity();
		
	if event.is_action_released("ui_right"):
		is_right_down = false;
		
		if not is_left_down:
			almost_stop_horizontal_velocity();
	
	if event.is_action_released("jump"):
		is_jump_down = false;
			
			
func stop_horizontal_velocity():
	apply_central_impulse(Vector2(-mass * linear_velocity.x, 0))
	
func almost_stop_horizontal_velocity():
	apply_central_impulse(Vector2(-mass * linear_velocity.x * 0.95, 0))

func apply_jump_impulse():
	$Sprite/SFX/SfxJump.play();
	apply_central_impulse(Vector2(0, jump_impulse))
	
	
func get_gravity() -> Vector2:
	return ProjectSettings.get_setting("physics/2d/default_gravity_vector");
