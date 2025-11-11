extends Node2D
@export var sir_scene: PackedScene
# Called when the node enters the scene tree for the first time.


func _ready() -> void:
	$StartTimer.start()
	$GetReadyText.show()
	$Sounds/MusicMainGame.play()
	$GameOverText.hide()
	GlobalScript.student_hit = false
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if GlobalScript.sirscore == 40 and GlobalScript.student_hit == false:
		on_score_reach_40()
	$Score.text = "Score : " + str(GlobalScript.sirscore)


func _on_student_hit() -> void:
	$GameOverText.show()
	$GameOverTimer.start()
	$SirTimer.stop()
	$Sounds/MusicMainGame.stop()
	$Sounds/SfxGameOver.play()
	GlobalScript.student_hit = true
	
	 # Replace with function body.


func _on_game_over_timer_timeout() -> void:
	$GameOverText.hide() # Replace with function body.
	get_tree().change_scene_to_file("res://Level2Menu.tscn")
	MusicPlayer.get_node("AudioStreamPlayer").play()
	if GlobalScript.score_enabled:
		return
	else:
		GlobalScript.sirscore = 0



func _on_sir_timer_timeout() -> void:
	GlobalScript.sir_tracking_time = 1.5
	$SirTimer.wait_time = 2
	GlobalScript.sirspeed = 300
	if GlobalScript.sirscore < 10:
		var factor = 1.5
		var sir = sir_scene.instantiate()
		
		var sir_spawn_location = $SirPath/SirSpawnLocation
		sir_spawn_location.progress_ratio = randf()
		
		sir.position = sir_spawn_location.position
		
		var direction = sir_spawn_location.rotation + PI/2
		
		direction += randf_range(-PI / 4 , PI / 4)
		sir.rotation = direction
		var velocity = Vector2(randf_range(350.0, 450.0), 0.0)
		sir.linear_velocity = velocity.rotated(direction)
		
		var collision_shape = sir.get_node("CollisionShape2D")
		
		if collision_shape.shape is CapsuleShape2D:
			collision_shape.shape.radius *= factor*0.7
			collision_shape.shape.height *= factor*0.7
		sir.get_node("AnimatedSprite2D").scale *= factor
		add_child(sir)
	elif GlobalScript.sirscore == 10:
		# Animation Script 
		$Sounds/SfxLevelUp.play()
		$Sounds/ThreeStudentsVid.play()
		$Student/CollisionShape2D.disabled = true
		$SirTimer.stop()
		#get_tree().change_scene_to_file("res://three_students_video.tscn")
		$StartTimer.stop()
		#$ScorePlusTimer.wait_time = $StartTimer.wait_time
		$SirTimer.wait_time = 5
	elif GlobalScript.sirscore > 10 and GlobalScript.sirscore < 40:
		GlobalScript.sir_tracking_time = 3.0
		$SirTimer.wait_time = 5
		GlobalScript.sirspeed = 250
		for i in 3:
			var factor = 1.5
			var sir = sir_scene.instantiate()
			
			var sir_spawn_location = $SirPath/SirSpawnLocation
			sir_spawn_location.progress_ratio = randf()
			
			sir.position = sir_spawn_location.position
			
			var direction = sir_spawn_location.rotation + PI/2
			
			direction += randf_range(-PI / 4 , PI / 4)
			sir.rotation = direction
			var velocity = Vector2(randf_range(200.0, 300.0), 0.0)
			sir.linear_velocity = velocity.rotated(direction)
			
			var collision_shape = sir.get_node("CollisionShape2D")
			
			if collision_shape.shape is CapsuleShape2D:
				collision_shape.shape.radius *= factor*0.7
				collision_shape.shape.height *= factor*0.7
			sir.get_node("AnimatedSprite2D").scale *= factor
			add_child(sir)
	#elif GlobalScript.sirscore == 40:
		#$Sounds/SfxLevelUp.play()
		#$Sounds/SirSuperSaiyan.play()
		#$Student/CollisionShape2D.disabled = true
		#$SirTimer.stop()
		##get_tree().change_scene_to_file("res://three_students_video.tscn")
		#$StartTimer.stop()
	elif GlobalScript.sirscore > 40 and GlobalScript.sirscore < 60:
		GlobalScript.sir_tracking_time = 0.6
		$SirTimer.wait_time = 2
		GlobalScript.sirspeed = 8.5 * GlobalScript.sirscore
		var factor = 1.5
		var sir = sir_scene.instantiate()
		
		var sir_spawn_location = $SirPath/SirSpawnLocation
		sir_spawn_location.progress_ratio = randf()
		
		sir.position = sir_spawn_location.position
		
		var direction = sir_spawn_location.rotation + PI/2
		
		direction += randf_range(-PI / 4 , PI / 4)
		sir.rotation = direction
		var velocity = Vector2(randf_range(200.0, 300.0), 0.0)
		sir.linear_velocity = velocity.rotated(direction)
		
		var collision_shape = sir.get_node("CollisionShape2D")
		collision_shape.disabled = false
		if collision_shape.shape is CapsuleShape2D:
			collision_shape.shape.radius *= factor*0.7
			collision_shape.shape.height *= factor*0.7
		sir.get_node("AnimatedSprite2D").scale *= factor
		add_child(sir)
	elif GlobalScript.sirscore == 60:
		# Sir Super Saiyan 1 mode 
		var sir = sir_scene.instantiate()
		var collision_shape = sir.get_node("CollisionShape2D")
		collision_shape.disabled = false
		GlobalScript.sirscore += 1
		
	elif GlobalScript.sirscore > 60:
		GlobalScript.sir_tracking_time = 0.2
		$SirTimer.wait_time = 2
		GlobalScript.sirspeed = 8 * GlobalScript.sirscore
		var factor = 1.5
		var sir = sir_scene.instantiate()
		
		var sir_spawn_location = $SirPath/SirSpawnLocation
		sir_spawn_location.progress_ratio = randf()
		
		sir.position = sir_spawn_location.position
		
		var direction = sir_spawn_location.rotation + PI/2
		
		direction += randf_range(-PI / 4 , PI / 4)
		sir.rotation = direction
		var velocity = Vector2(randf_range(200.0, 300.0), 0.0)
		sir.linear_velocity = velocity.rotated(direction)
		
		var collision_shape = sir.get_node("CollisionShape2D")
		collision_shape.disabled = false
		if collision_shape.shape is CapsuleShape2D:
			collision_shape.shape.radius *= factor*0.7
			collision_shape.shape.height *= factor*0.7
		sir.get_node("AnimatedSprite2D").scale *= factor
		
		add_child(sir)
		
		
		

func _on_start_timer_timeout() -> void:
	$SirTimer.start() # Replace with function body.
	$ScoreTimer.start()
	$GetReadyText.hide()


func _on_score_plus_timer_timeout() -> void:
	GlobalScript.sirscore += 1


func _on_three_students_vid_finished() -> void:
	$StartTimer.start()
	$Sounds/ThreeStudentsVid.hide()
	#$ScorePlusTimer.start()
	$GetReadyText.text = """Get Ready !!
	Three Students try
	to catch you."""
	$GetReadyText.add_theme_font_size_override("font_size", 48)
	$GetReadyText.show()
	$Student/CollisionShape2D.disabled = false
	GlobalScript.sirscore += 1


func _on_sir_super_saiyan_finished() -> void:
	$StartTimer.start()
	$Sounds/SirSuperSaiyan.hide()
	#$ScorePlusTimer.start()
	$GetReadyText.text = """Get Ready !!
	Sir has gotten
	VERY ANGRY!"""
	$GetReadyText.add_theme_font_size_override("font_size", 48)
	$GetReadyText.show()
	$Student/CollisionShape2D.disabled = false
	GlobalScript.sirscore = 41
	GlobalScript.sirscore += 1

func on_score_reach_40():
	$Sounds/SfxLevelUp.play()
	$Sounds/SirSuperSaiyan.play()
	$Student/CollisionShape2D.disabled = true
	$SirTimer.stop()
	#get_tree().change_scene_to_file("res://three_students_video.tscn")
	$StartTimer.stop()
	
