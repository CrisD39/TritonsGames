extends Node2D


func _ready():
	await get_tree().process_frame
	$Player.die.connect(end_game)
	$Player.misil.connect(dispararMisil)
	crear_nueva_ola()
	
func end_game():
	print("se llamo a endgame")
	get_tree().change_scene_to_file("res://end_game_screen.tscn")


func _on_enemy_died(points: int) -> void:
	Global.add_score(points)  # actualiza y dispara score_changed
	check_fin_ola()

func crear_nueva_ola():
	var array_puntos = $spawn.get_children()
	for i in range(1,3):
		var random_pos = array_puntos.pick_random().global_position
		invocar_enemigo(random_pos)
		if get_tree(): 
			await get_tree().create_timer(0.5).timeout
		$Timer.start()
		
func invocar_enemigo(pos: Vector2):
	const ENEMIGO = preload("res://enemy_plane_1.tscn")
	var instancia_enemigo = ENEMIGO.instantiate()
	instancia_enemigo.died.connect(_on_enemy_died)
	instancia_enemigo.global_position = pos
	#instancia_enemigo.target = $Player
	$Enemigos.add_child(instancia_enemigo)
	print("se creo enemigo")
	
func check_fin_ola() -> bool:
	if($Enemigos.get_children().size() == 1):
		print("check_fin_ola")
		crear_nueva_ola()
		$Timer.start()
		return true
	return false

func dispararMisil():
	var array_target = $Enemigos.get_children()
	if($Enemigos.get_children().size() != 0):
		var target = array_target.pick_random()
		$Player.disparar_misil(target)
