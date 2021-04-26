extends StaticBody2D;


func _ready():
	pass


func _physics_process(delta):	
	sync_shape_with_floor_nodes();
	print_shape();
	update();

func _process(delta):
	pass


func get_edge_shape() -> ConvexPolygonShape2D:
	return shape_owner_get_shape(0, 0) as ConvexPolygonShape2D;


func _draw():
	pass
	# draw_line(get_edge_shape().points, get_edge_shape().b, Color.wheat, 5.0, true);
	# draw_line($FloorNode0.position, $FloorNode1.position, Color.wheat, 5.0, true);
	draw_colored_polygon(get_edge_shape().points, Color.rebeccapurple);
	print(get_edge_shape().points)

func _input(event):
	if event is InputEventMouseButton:
		if event.pressed and event.button_index == BUTTON_LEFT:
			pass
			
		if event.pressed and event.button_index == BUTTON_RIGHT:
			pass


func sync_shape_with_floor_nodes():
	var points = get_edge_shape().points
	points.set(0, $FloorNode0.position);
	points.set(1, $FloorNode1.position);
	points.set(2, $FloorNode1.original_position - self.position)
	points.set(3, $FloorNode0.original_position - self.position)
	
	var shape = ConvexPolygonShape2D.new()
	shape.points = points;
	
	shape_owner_clear_shapes(0);
	shape_owner_add_shape(0, shape);


func print_shape():
	pass
	# print(get_edge_shape().points);
