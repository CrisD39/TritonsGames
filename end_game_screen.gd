extends Control

func _ready() -> void:
	$score.text = "score: " + str(Global.score)
	$end_game_music.play(36)
	
func _on_retry_button_pressed() -> void:
	Global.reset_score()
	Global.reset_life()
	get_tree().change_scene_to_file("res://game.tscn")

func _on_exit_button_pressed() -> void:
	get_tree().quit()
