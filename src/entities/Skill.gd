class_name Skill

enum skill_types {
	ATTACK,
	BUFF,
	DEBUFF
}

enum stats {
	ATTACK,
	DEFENCE,
	SPEED
}


var name
var description
var type
var affected_stat
var value


func _init(name, description, type, affected_stat, amount) -> void:
	self.name = name
	self.description = description
	self.type = type
	self.affected_stat = affected_stat
	self.value = amount
