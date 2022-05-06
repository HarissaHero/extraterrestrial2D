class_name Character

var name
var alias
var skills := []

var level = 1
var experience = 1

var _base_attack = 50.0
var _base_defence = 50.0
var _base_health = 100.0

var bonus_attack = 0
var bonus_defence = 0
var bonus_health = 0

func _init(name, alias, skills) -> void:
	self.name = name
	self.alias = alias
	self.skills = skills

func experience_up(experience: int) -> void:
	self.experience += experience
	
func get_total_attack():
	return self._base_attack + (self.bonus_attack * 10)

func get_total_defence():
	return self._base_defence + (self.bonus_defence * 10)

func get_total_health():
	return self._base_health + (self.bonus_defence * 10)
	
func level_up():
	self.experience = 0
	self.level += 1
	self._base_attack += self.level * 7.25
	self._base_attack += self.level * 3.625
	self._base_attack += self.level * 7.25
	
func idle() -> String:
	return self.alias + "_idle"
	
func walk() -> String:
	return self.alias + "_walk"

func jump() -> String:
	return self.alias + "_jump"
