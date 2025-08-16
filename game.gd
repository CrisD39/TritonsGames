extends Node2D

var cantEnemigos = 5

func _ready():
	await get_tree().process_frame
	$Player.die.connect(end_game)
	$Player.misil.connect(dispararMisil)
	crear_nueva_ola()
	
func end_game():
	get_tree().change_scene_to_file("res://end_game_screen.tscn")


func _on_enemy_died(points: int) -> void:
	Global.add_score(points)  # actualiza y dispara score_changed
	check_fin_ola()

func crear_nueva_ola():
	var array_puntos = $spawn.get_children()
	for i in range(1,cantEnemigos):
		var random_pos = array_puntos.pick_random().global_position
		invocar_enemigo(random_pos)
		if get_tree(): 
			await get_tree().create_timer(0.5).timeout
		$Timer.start()
		
func invocar_enemigo(pos: Vector2):
	var array_rand = [1,2,3]
	var rand = array_rand.pick_random()
	var instancia_enemigo
	if rand == 1:
		instancia_enemigo = preload("res://enemy_plane_1.tscn").instantiate()
	if rand == 2:
		instancia_enemigo = preload("res://enemy_plane_2.tscn").instantiate()
	if rand == 3:
		instancia_enemigo = preload("res://enemy_plane_3.tscn").instantiate()
		instancia_enemigo.target = $Player
	
	instancia_enemigo.died.connect(_on_enemy_died)
	instancia_enemigo.global_position = pos
	$Enemigos.add_child(instancia_enemigo)
	
func check_fin_ola() -> bool:
	if($Enemigos.get_children().size() == 1):
		crear_nueva_ola()
		$Timer.start()
		return true
	return false

func dispararMisil():
	var array_target = $Enemigos.get_children()
	if($Enemigos.get_children().size() != 0):
		var target = array_target.pick_random()
		$Player.disparar_misil(target)
