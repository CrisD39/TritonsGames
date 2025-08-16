extends Node

signal score_changed(new_score: int)
signal damage_receive

var score: int = 0
var vida: int = 3


func reset_score() -> void:
	score = 0
	emit_signal("score_changed", score)

func add_score(points: int) -> void:
	score += points
	emit_signal("score_changed", score)

func damage_done() -> void:
	vida-= 1
	damage_receive.emit()

func reset_life() -> void:
	vida = 3
	damage_receive.emit()
	
