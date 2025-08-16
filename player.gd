extends CharacterBody2D

var speed = 400
@export var life = 1

signal die
signal misil

func _physics_process(delta: float) -> void:
	if (Input.is_action_just_pressed("disparar")):
		disparar()
	
	if (Input.is_action_just_pressed("dispararMisil")):
		misil.emit()
	
	var direction = Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	velocity = direction*speed
	move_and_slide()

func disparar():
	const BALA = preload("res://bullet.tscn")
	var disparo = BALA.instantiate()
	disparo.global_position = global_position
	get_parent().add_child(disparo)

var misilKey: bool = true
func disparar_misil(tar: Node2D):
	if misilKey:
		const  MISIL = preload("res://missile.tscn")
		var disparo = MISIL.instantiate()
		disparo.global_position = global_position
		disparo.target = tar
		get_parent().add_child(disparo)
		if get_tree(): 
			misilKey = false
			await get_tree().create_timer(5).timeout
			misilKey = true
	
#otra forma de ver acción por refresco
#func _process(delta):
#	if Input.is_action_just_pressed("disparar"):
#		disparar()

@onready var anim = $AnimatedSprite2D
@onready var postCombustion = $CPUParticles2D

func receive_damage():
	life-=1
	print(life)
	if(life== 0):
		die.emit()

func _process(delta):
	if Input.is_action_pressed("ui_right"):
		anim.animation = "turn_right"
		anim.frame = 1  # El fotograma que querés mantener
		anim.pause()  # Pausa en ese fram
		
	if Input.is_action_pressed("ui_left"):
		anim.animation = "turn_left"
		anim.frame = 1  # El fotograma que querés mantener
		anim.pause()  # Pausa en ese frame
		
	if Input.is_action_just_released("ui_right") or Input.is_action_just_released("ui_left"):
		anim.animation = "idle"
		anim.play()


func _on_area_2d_area_entered(area: Area2D) -> void:
	receive_damage()
	if area.is_in_group("hurtbox"): #por ahi tendria que ser enemigo pero es lo mismo fue
		var enemy := area.get_parent()
		if enemy and enemy.has_method("die"):
			enemy.die(self)
