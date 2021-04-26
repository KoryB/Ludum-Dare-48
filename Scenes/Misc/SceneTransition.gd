extends ColorRect

export(String, FILE, "*.tscn") var next_scene_path

onready var _anim_player := $AnimationPlayer
onready var _audio_player := $AudioStreamPlayer

func _ready():
	print("ready")
	_anim_player.play_backwards("Fade");
	

func _process(delta):
	if Input.is_action_just_pressed("next_level"):
		transition_to();
	
	
func transition_to(_next_scene := next_scene_path) -> void:
	_audio_player.play()
	_anim_player.play("Fade");
	yield(_anim_player, "animation_finished")
	yield(_audio_player, "finished")
	
	get_tree().change_scene(_next_scene);

