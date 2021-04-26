extends Control

func _ready():
	randomize();


func _on_Button_pressed():
	$SceneTransitionRect.transition_to();
