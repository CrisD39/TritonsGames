extends Node

signal score_changed(new_score: int)

var score: int = 0

func reset_score() -> void:
	score = 0
	emit_signal("score_changed", score)

func add_score(points: int) -> void:
	score += points
	emit_signal("score_changed", score)
