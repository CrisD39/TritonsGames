extends CanvasLayer

func _ready() -> void:
	Global.score_changed.connect(update_score)
	Global.damage_receive.connect(reduce_heart)
	Global.misil_signal.connect(update_misil)
	
func update_score(puntos:int) -> void :
	$score_label.text = "score: " + str(puntos)

func reduce_heart()->void:
	$lifes.set_health(Global.vida)

func update_misil(value:bool):
	$misil.set_enabled(value)
