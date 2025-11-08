extends Node2D
@export var sir_scene: PackedScene
# Called when the node enters the scene tree for the first time.


func _ready() -> void:
	MusicPlayer.get_node("AudioStreamPlayer").play()
	$GameOverText.hide()
	

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	$Score.text = "Score : " + str(GlobalScript.sirscore)


func _on_student_hit() -> void:
	$GameOverText.show()
	$GameOverTimer.start()
	$SirTimer.stop()
	
	 # Replace with function body.


func _on_game_over_timer_timeout() -> void:
	$GameOverText.hide() # Replace with function body.
	get_tree().change_scene_to_file("res://Level2Menu.tscn")
	MusicPlayer.get_node("AudioStreamPlayer").play()
	GlobalScript.sirscore = 0



func _on_sir_timer_timeout() -> void:
	if GlobalScript.sirscore < 20:
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
	elif GlobalScript.sirscore == 20:
		# Animation Script 
		$Sequence1Timer.start()
		await get_tree().create_timer(5.0).timeout
		GlobalScript.sirscore += 1
	elif GlobalScript.sirscore > 20 and GlobalScript.sirscore < 50:
		for i in 3:
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
	


	

func _on_start_timer_timeout() -> void:
	$SirTimer.start() # Replace with function body.
	$ScoreTimer.start()
