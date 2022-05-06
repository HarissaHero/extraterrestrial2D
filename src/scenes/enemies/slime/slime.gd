extends Actor

var floating_numbers = preload("res://src/scenes/hud/numbers_label/numbered_label.tscn")

var is_near_player = false
var health = 1000
var hit_speed := Vector2(100.0, 50.0)

func _ready() -> void:
	pass

func _on_PlayerDetector_body_exited(body: Node) -> void:
	is_near_player = false


func _on_PlayerDetector_body_entered(body: KinematicBody2D) -> void:
	is_near_player = true
	

func _on_ContactDetector_body_entered(body: KinematicBody2D) -> void:
	var damage = 100
	onHit(damage)


func onHit(damage : float) -> void:
	print('got hit')
	health -= damage
	var text = floating_numbers.instance()
	text.amount = damage
	add_child(text)
	

func onPush(origin : Vector2) -> void:
	print('getiing pushed')
	_velocity = (global_position - origin).normalized() * hit_speed
	move_and_slide(_velocity)

func _physics_process(delta: float) -> void:
	if health <= 0:
		$AnimatedSprite.play("die")
		queue_free()
		
	if is_near_player:
		var player = get_parent().get_node("player")
		var direction = (player.global_position - global_position).normalized()
		_velocity = calculate_move_velocity(_velocity, direction, false)
		_velocity = move_and_slide(_velocity, FLOOR_NORMAL)
		$AnimatedSprite.flip_h = _velocity.x > 0
		$AnimatedSprite.play("walk")
	else:
		_velocity.y += gravity * delta
		_velocity.x = 0.0
		_velocity = move_and_slide(_velocity, FLOOR_NORMAL)
		$AnimatedSprite.play("idle")
