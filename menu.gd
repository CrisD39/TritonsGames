extends Control

@onready var menu_music: AudioStreamPlayer2D = $menuMusic

func _ready() -> void:
	# Inicia la música cuando se cargue la escena
	print("hola")
	menu_music.play()# Reproduce la música
		
func _on_play_pressed() -> void:
	change_scene("res://game.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()

#Todo Ver como chequeo la ruta
func change_scene(ruta: String):
	var escena_nueva = load(ruta)  # Cargar la nueva escena
	if escena_nueva:
		get_tree().change_scene_to_file(ruta)  # Cambiar a la nueva escena
	else:
		print("Error: No se pudo cargar la escena en: " + ruta)
