extends Area2D

class_name AreOfEffect

onready var tween := get_node("Tween")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	print("called")
	tween.interpolate_property(self, "scale", scale, Vector2(100.0, 100.0), 1.0, Tween.TRANS_LINEAR, Tween.EASE_OUT_IN, 0.1)
	tween.start()
	yield(get_tree().create_timer(1.0), "timeout")
	queue_free()


func _process(delta: float) -> void:
	var damage = 10
	var targets = get_overlapping_bodies()
	for target in targets:
		target.onHit(damage)
		target.onPush(self.global_position)
