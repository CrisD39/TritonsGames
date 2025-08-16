extends CharacterBody2D

var speed = 400

signal die
signal misil
signal damage
var misilKey = Global.misilAvailable

@export var muzzle_offset := 20.0  # píxeles hacia la punta

@export var invincibility_time := 1.5
var invincible := false
var dead := false

@onready var anim: AnimatedSprite2D = $AnimatedSprite2D
@onready var hurtbox: Area2D = $Area2D

func _physics_process(delta: float) -> void:
	if dead:
		return
	if Input.is_action_just_pressed("disparar"):
		disparar()
	if Input.is_action_just_pressed("dispararMisil"):
		misil.emit()

	var direction := Input.get_vector("ui_left","ui_right","ui_up","ui_down")
	velocity = direction * speed
	move_and_slide()

# ---------------- Invencibilidad ----------------

# mantengo el nombre por compatibilidad si ya lo llamabas así
func _set_invicible() -> void:
	_start_invincibility()

func _start_invincibility() -> void:
	if invincible:
		return
	invincible = true
	_set_hurtbox_enabled(false)

	# reproducí la animación de daño una sola vez al entrar
	if is_instance_valid(anim):
		anim.play("hurt_animation")

	await get_tree().create_timer(invincibility_time).timeout

	# salir de i-frames: habilitar hurtbox y volver a idle
	_set_hurtbox_enabled(true)
	invincible = false
	if is_instance_valid(anim):
		anim.play("idle")

func _set_hurtbox_enabled(enabled: bool) -> void:
	if is_instance_valid(hurtbox):
		hurtbox.set_deferred("monitoring", enabled)

# ---------------- Disparo ----------------


func disparar():
	const BALA = preload("res://bullet.tscn")
	var disparo = BALA.instantiate()
	disparo.global_position = global_position + Vector2(0, -muzzle_offset)
	get_parent().add_child(disparo)


func disparar_misil(tar: Node2D):
	if Global.misilAvailable:
		const MISIL = preload("res://missile.tscn")
		var disparo = MISIL.instantiate()
		disparo.global_position = global_position
		disparo.target = tar
		get_parent().add_child(disparo)
		if get_tree():
			Global._set_misil_available(false)
			await get_tree().create_timer(5).timeout
			Global._set_misil_available(true)

# ---------------- Daño ----------------

func receive_damage():
	if invincible:
		return
	damage.emit()
	Global.damage_done()
	if Global.vida <= 0:
		_die()
	else:
		_start_invincibility()

#------------------- Muerte -------------------------
func _die():
	dead = true
	$CPUParticles2D.hide()
	anim.play("die_animation")
	die.emit()
# ---------------- Animación de movimiento ----------------

func _process(delta):
	# mientras esté invencible no tocamos la anim para no pisar "hurt_animation"
	if invincible:
		return
	if dead:
		return 
		
	if Input.is_action_pressed("ui_right"):
		anim.animation = "turn_right"
		anim.frame = 1
		anim.pause()
	elif Input.is_action_pressed("ui_left"):
		anim.animation = "turn_left"
		anim.frame = 1
		anim.pause()
	else:
		# si no está girando, reproducir idle
		if anim.animation != "idle" or not anim.is_playing():
			anim.animation = "idle"
			anim.play()

# ---------------- Colisiones ----------------

func _on_area_2d_area_entered(area: Area2D) -> void:
	if invincible:
		return

	receive_damage()

	if area.is_in_group("hurtbox"):
		var enemy := area.get_parent()
		if enemy and enemy.has_method("die"):
			enemy.die(self)
