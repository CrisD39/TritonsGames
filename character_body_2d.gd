extends CharacterBody2D

var speed = 300

func _physics_process(delta: float) -> void:
	if (Input.is_action_just_pressed("disparar")):
		disparar()
	var direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	velocity = direction*speed
	move_and_slide()

func disparar():
	const BALA = preload("res://bullet.tscn")
	var disparo = BALA.instantiate()
	disparo.global_position = global_position
	get_parent().add_child(disparo)

#otra forma de ver acción por refresco
#func _process(delta):
#	if Input.is_action_just_pressed("disparar"):
#		disparar()
