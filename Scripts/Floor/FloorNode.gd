extends Node2D

export(float, 0, 1000) var hookes_strength := 500;
export(float, 0, 256) var max_length := 16;
export var follow_velocity := 100;

var damping_strength: float;
var velocity := Vector2(0, 0);
var acceleration := Vector2(0, 0);

var max_length_squared: float;
var original_position: Vector2;

var follow_point: Vector2
var following := false

class_name FloorNode, "res://Assets/Particles/circle.png"

func _ready():
	# Critical damping: https://courses.lumenlearning.com/suny-osuniversityphysics/chapter/15-5-damped-oscillations/
	damping_strength = sqrt(4 * hookes_strength);
	
	max_length_squared = max_length * max_length;
	original_position.x = global_position.x;
	original_position.y = global_position.y;
	
func _physics_process(delta):
	if not following:
		var local_position = global_position - original_position;
		if local_position.length_squared() > max_length_squared:
			global_position = original_position + local_position.clamped(max_length);
			
		var to_origin = original_position - global_position;
		
		var to_origin_force = hookes_strength * to_origin;
		var damping_force = -damping_strength * self.velocity;
		
		add_force(to_origin_force);
		add_force(damping_force);
		
		velocity += acceleration * delta;
		global_position += velocity * delta;
		
	if following:
		var to_target = (follow_point - original_position).clamped(max_length);
		
		global_position = original_position + to_target;
		
		
	clear_forces();
	update();
	

func add_force(force: Vector2):
	acceleration += force;
	
func add_follow(point: Vector2):
	follow_point += point;
	
	if following:
		follow_point /= 2;
	else:
		following = true
	
	
func clear_forces():
	acceleration *= 0;
	follow_point *= 0;
	following = false;
	
func _input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == BUTTON_LEFT:
			print('pressed');
			global_position.y -= 32;

func _draw():
	draw_circle(Vector2(0, 0), 3, Color.violet);
	draw_circle(original_position - global_position, 3, Color.beige);
