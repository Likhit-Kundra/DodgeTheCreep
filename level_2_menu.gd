extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_options_button_pressed():
	get_tree().change_scene_to_file("res://PlayAsManojSirOptionsScene.tscn")


func _on_start_button_pressed():
	pass
	


func _on_back_to_level_1_button_pressed():
	get_tree().change_scene_to_file("res://main.tscn")
