extends Node

var hearts = 5 setget set_hearts
var max_hearts = 5 setget set_max_hearts

onready var label = $Label

func set_hearts(value):
	hearts = clamp(value, 0, max_hearts)

func set_max_hearts(value):
	max_hearts = max(value, 1)

func _ready():
	self.max_hearts = PlayerStats.max_health
	self.hearts = PlayerStats.health


































#signal max_changed(new_max)
#signal changed(new_amount)
#signal depleted

#export(int) var max_amount = 10 setget set_max
#onready var current = max_amount setget set_current


#func _ready():
#	_initialize()


#func set_max(new_max):
#	max_amount = max(1, new_max)
#	emit_signal("max_changed", max_amount)

#func set_current(new_value):
#	current = clamp(current, 0, max_amount)
#	emit_signal("changed", current)
	
#	if current == 0:
#		emit_signal("depleted")

#func _initialize():
#	emit_signal("max_changed", max_amount)
#	emit_signal("changed", current)






