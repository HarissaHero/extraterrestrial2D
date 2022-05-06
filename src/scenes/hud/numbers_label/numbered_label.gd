extends Position2D

onready var label : Label = get_node("Label")
onready var tween = get_node("Tween")

export var mouvement_amplitude_x : int = 40
export var mouvement_amplitude_y : int = 80
export var start_index := 20

var amount = 0
var _velocity := Vector2.ZERO

func _on_Tween_tween_all_completed() -> void:
	self.queue_free()


func _ready() -> void:
	label.set_text(str(amount)) 
	var side_mouvement = randi() % mouvement_amplitude_x - start_index
	_velocity = Vector2(side_mouvement, mouvement_amplitude_y)
	tween.interpolate_property(self, "scale", scale, Vector2(1.0, 1.0), 0.2, Tween.TRANS_LINEAR, Tween.EASE_OUT_IN)
	tween.interpolate_property(self, "scale", Vector2(1.0, 1.0), Vector2(0.1, 0.1), 0.7, Tween.TRANS_LINEAR, Tween.EASE_OUT, 0.3)
	tween.start()

func _process(delta: float) -> void:
	position -= _velocity * delta
