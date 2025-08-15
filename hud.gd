extends CanvasLayer

func _ready() -> void:
	Global.score_changed.connect(update_score)
	
func update_score(puntos:int) -> void :
	$score_label.text = "score: " + str(puntos)
