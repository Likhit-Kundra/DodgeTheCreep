extends RigidBody2D

@export var speed: float = GlobalScript.sirspeed
@export var turn_rate: float = 4.0     # how sharply it curves
@export var tracking_time: float = GlobalScript.sir_tracking_time	 # seconds it keeps adjusting toward the player

var direction: Vector2
var time_alive: float = 0.0

func _ready() -> void:
	if is_instance_valid(GlobalScript.player):
		direction = (GlobalScript.player.global_position - global_position).normalized()
		linear_velocity = direction * speed
	
	
	if GlobalScript.sirscore >= 10 and GlobalScript.sirscore <= 40:
		$AnimatedSprite2D.animation = "ThreeStudents"
		$AnimatedSprite2D.scale = Vector2(0.25,0.25)
		$CollisionShape2D.rotation = 90
		$AnimatedSprite2D.play()
		
	elif GlobalScript.sirscore > 40 and GlobalScript.sirscore <= 60:
		$AnimatedSprite2D.animation = "SuperSaiyanSir"
		$AnimatedSprite2D.scale = Vector2(0.07,0.07)
		$CollisionShape2D.rotation = 90
		$AnimatedSprite2D.rotation = -80
	else:
		$AnimatedSprite2D.animation = "default"
		$AnimatedSprite2D.scale = Vector2(0.1,0.1)
		$CollisionShape2D.rotation = 90
		$AnimatedSprite2D.rotation = -80
		$AnimatedSprite2D.play()

func _physics_process(delta: float) -> void:
	time_alive += delta

	if is_instance_valid(GlobalScript.player) and time_alive < tracking_time:
		# Adjust trajectory slightly toward player for a short duration
		var target_dir = (GlobalScript.player.global_position - global_position).normalized()
		direction = direction.lerp(target_dir, turn_rate * delta).normalized()

	# After tracking_time, it just continues straight
	linear_velocity = direction * speed
	rotation = direction.angle()
	
func _on_visible_on_screen_notifier_2d_screen_exited() -> void:
	GlobalScript.sirscore += 1
	queue_free()
