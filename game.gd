extends Node2D


func _ready():
	$Player.die.connect(end_game)
	
func end_game():
	print("se llamo a endgame")
	get_tree().change_scene_to_file("res://end_game_screen.tscn")
