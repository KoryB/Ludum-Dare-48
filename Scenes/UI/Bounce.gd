extends Sprite

export var speed := 30

var xdir = 1
var ydir = 1

var viewport_size: Vector2
var rng: RandomNumberGenerator

func _ready():
	rng = get_parent().rng;
	
	viewport_size = get_viewport_rect().size;
	
	xdir = random_sign();
	ydir = random_sign();
	
	speed += random_sign() * speed * rng.randf_range(0.3, 0.7);
	
	scale *= rng.randf_range(0.5, 10.0);
	
	modulate.r = rng.randf()
	modulate.g = rng.randf()
	modulate.b = rng.randf()
	modulate.a = rng.randf_range(0.2, 0.7);
	
	position.x = rng.randf_range(1.0, viewport_size.x - 1)
	position.y = rng.randf_range(1.0, viewport_size.y - 1)
	
	
func _process(delta):
	var tx = position.x + xdir * speed * delta;
	var ty = position.y + ydir * speed * delta;
	
	if tx < 0 or tx > viewport_size.x:
		tx = position.x
		xdir *= -1
		
	if ty < 0 or ty > viewport_size.y:
		ty = position.y
		ydir *= -1
		
	position.x = tx
	position.y = ty
	
func random_sign():
	return 2*rng.randi_range(0, 1) - 1;
