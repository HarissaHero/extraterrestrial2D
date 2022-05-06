extends Actor

var Character = load('res://src/entities/Character.gd')
var Skill = load('res://src/entities/Skill.gd')
var AoeAttack = preload("res://src/scenes/attacks/aoe_attack.tscn")

var base_attack = Skill.new("Stomp", "Basic attack deals 100 damage", Skill.skill_types.ATTACK, null, 100.0)

var windy = Character.new("Windy", "windy", [base_attack])
var fyr = Character.new("Fyr", "fyr", [base_attack])
var bubble = Character.new("Bubble", "bubble", [base_attack])

var characters := {
	0: windy,
	1: fyr,
	2: bubble 
}

var selected_character = 0

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


func _physics_process(delta: float) -> void:
	var is_jump_interrupted := Input.is_action_just_released("p_jump") and _velocity.y < 0.0
	var skill_request := get_skill_to_call()
	
	if skill_request > -1:
		print("aoe")
		var aoe = AoeAttack.instance()
		add_child(aoe)

	var transformation_request := Input.is_action_just_pressed("p_transform")
	if transformation_request:
		selected_character = (selected_character + 1) % 3
	
	var direction := get_direction()
	_velocity = calculate_move_velocity(_velocity, direction, is_jump_interrupted)
	
	if _velocity.x != 0.0:
		$AnimatedSprite.flip_h = _velocity.x < 0.0
	
	_velocity = move_and_slide(_velocity, FLOOR_NORMAL)
	
	var animation = characters[selected_character].walk() if _velocity.x != 0.0 else characters[selected_character].idle()
	if _velocity.y != 0:
		animation = characters[selected_character].jump() 
	
	$AnimatedSprite.play(animation)

	
func get_direction() -> Vector2:
	return Vector2(Input.get_action_strength("p_move_right") - Input.get_action_strength("p_move_left"),
	-1.0 if Input.is_action_just_pressed("p_jump") and is_on_floor() else 1.0)

func get_skill_to_call() -> int:
	if Input.is_action_just_pressed("p_skill_1"):
		return 0
	if Input.is_action_just_pressed("p_skill_2"):
		return 1
	if Input.is_action_just_pressed("p_skill_3"):
		return 2
	if Input.is_action_just_pressed("p_skill_4"):
		return 3
	return -1
