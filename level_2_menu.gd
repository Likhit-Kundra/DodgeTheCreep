extends Control
var tween = create_tween()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	$SkipVidButton.hide()
	$VideoStreamPlayer.hide()
	MusicPlayer.get_node("AudioStreamPlayer").stream.loop = true
	MusicPlayer.get_node("AudioStreamPlayer").play()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_options_button_pressed():
	get_tree().change_scene_to_file("res://PlayAsManojSirOptionsScene.tscn")


func _on_start_button_pressed():
	MusicPlayer.get_node("AudioStreamPlayer").stop()
	get_tree().change_scene_to_file("res://level_2_game_scene.tscn")
	


func _on_back_to_level_1_button_pressed():
	MusicPlayer.get_node("AudioStreamPlayer").stop()
	get_tree().change_scene_to_file("res://main.tscn")



func _on_backstory_button_pressed():
	MusicPlayer.get_node("AudioStreamPlayer").stop()
	BackstoryVidStart()
	
	
func BackstoryVidStart():
	$RichTextLabel.hide()
	$MenuButtons.hide()
	$BackToLevel1Button.hide()
	$VideoStreamPlayer.stop() # Needed to stop the video if it was previously already being played
	$VideoStreamPlayer.show()
	$VideoStreamPlayer.play()
	$SkipVidButton.show()
	$BackstoryVidFinishTimer.start()
	
func BackstoryVidStop():
	$VideoStreamPlayer.hide()
	$RichTextLabel.show()
	

func _on_backstory_vid_finish_timer_timeout():
	$MenuButtons.show()
	$BackToLevel1Button.show()


func _on_video_stream_player_finished() -> void:
	BackstoryVidStop()
	$SkipVidButton.hide()


func _on_backstory_vid_audio_fade_timer_timeout():
	tween.tween_property($VideoStreamPlayer.volume_db,"volume_db" ,  -80.0, 2.0)


func _on_skip_vid_button_pressed() -> void:
	BackstoryVidStop()
	$VideoStreamPlayer.stop()
	$SkipVidButton.hide()
	$MenuButtons.show()
	$BackToLevel1Button.show()
	MusicPlayer.get_node("AudioStreamPlayer").play()
	
