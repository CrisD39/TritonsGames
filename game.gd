extends Node2D


func _ready():
	$Player.die.connect(end_game)
	$EnemyA.died.connect(_on_enemy_died)
	
	
func end_game():
	print("se llamo a endgame")
	get_tree().change_scene_to_file("res://end_game_screen.tscn")


func _on_enemy_died(points: int) -> void:
	Global.add_score(points)  # actualiza y dispara score_changed
