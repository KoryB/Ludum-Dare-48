extends Path2D

export var curve_bake_interval = 32.0;

var floor_edge_scene = preload("res://Scenes/Floor/FloorEdge.tscn");
var floor_edges: Array

var point_offset: Vector2

class_name FloorPath2D, "res://Assets/Particles/circle.png"

func _ready():
	floor_edges = []
	curve.bake_interval = curve_bake_interval
	point_offset = self.position
	self.position *= 0
	
	instance_edges()
	

func instance_edges():
	var points = curve.get_baked_points();
	
	print(points)
	
	for i in range(len(points) - 1):
		var a = points[i] + point_offset;
		var b = points[i + 1] + point_offset;
		
		var edge = floor_edge_scene.instance();
		edge.position = a
		edge.get_child(1).position = b - a
		
		add_child(edge);
