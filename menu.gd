extends Control

@onready var menu_music: AudioStreamPlayer2D = $menuMusic

func _process(delta: float) -> void:
	if $sonido_hornero.playing:
		if $sonido_hornero.get_playback_position() >= 5:
			$sonido_hornero.stop() #se puede hacer mas mejor pero fue

func _ready() -> void:
	menu_music.play()
		
func _on_play_pressed() -> void:
	change_scene("res://game.tscn")

func _on_exit_pressed() -> void:
	get_tree().quit()

#Todo Ver como chequeo la ruta
func change_scene(ruta: String):
	var escena_nueva = load(ruta)  
	if escena_nueva:
		get_tree().change_scene_to_file(ruta) 
	else:
		print("Error: No se pudo cargar la escena en: " + ruta)


func _on_button_hornero_pressed() -> void:
	$sonido_hornero.play()
		
