tool

extends Node2D


func _ready():
	pass


func _draw():
	var node0 = get_parent().get_child(0) as FloorNode;
	var node1 = get_parent().get_child(1) as FloorNode;
	draw_line(node0.position, node1.position, Color.black);
