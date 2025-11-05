extends CanvasLayer

signal start_game
@onready var sfx_game_over: AudioStreamPlayer = $"../SfxGameOver"
@onready var music_dodge_the_creeps_in_game: AudioStreamPlayer = $"../MusicDodgeTheCreepsInGame"
@onready var music_main_menu: AudioStreamPlayer = $"../MusicMainMenu"




# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func show_message(text):
	$Message.text = text
	$Message.show()
	$MessageTimer.start()
	
func show_game_start():
	show_message("Game Start") 
	music_main_menu.stop()
	music_dodge_the_creeps_in_game.stream.loop = true
	music_dodge_the_creeps_in_game.play()
	await $MessageTimer.timeout
	
	$Message.text = "Dodge the Creeps!"
	$Message.hide()
	

# Show the game over screen after player loses
func show_game_over():
	show_message("Game Over") # Custom Function 
	music_dodge_the_creeps_in_game.stop()
	sfx_game_over.play()
	
	await $MessageTimer.timeout
	
	music_main_menu.play()
	
	$Message.text = "Dodge the Creeps!"
	$Message.show()
	$StartButton.show()
	$OptionsButton.show()
	$Level2Button.show()
	
	
	
# Function to Update the score
func update_score(score):
	$ScoreLabel.text = str(score)
	

# When the Start button is pressed
func _on_start_button_pressed():
	$StartButton.hide()
	$OptionsButton.hide()
	$Level2Button.hide()
	start_game.emit()


func _on_message_timer_timeout():
	$Message.hide()


func _on_level_2_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Level2Menu.tscn")
