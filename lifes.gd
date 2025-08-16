extends HBoxContainer

@export var max_hearts: int = Global.vida: set = _set_max_hearts
@export var health: int = Global.vida : set = set_health

# Estilo/espaciado
@export var heart_size: Vector2 = Vector2(32, 32)
@export var separation: int = 8 : set = _set_separation

@onready var heart_template: TextureRect = $heart
var heart_texture: Texture2D

func _ready() -> void:
	# Guardamos la textura del corazón y usamos el nodo 'heart' como plantilla oculta
	heart_texture = heart_template.texture
	heart_template.visible = false
	if heart_template.custom_minimum_size == Vector2.ZERO:
		heart_template.custom_minimum_size = heart_size
	
	_set_separation(separation)
	_build_hearts()
	_refresh()

func _set_separation(v: int) -> void:
	separation = v
	add_theme_constant_override("separation", separation)

func _set_max_hearts(v: int) -> void:
	max_hearts = max(1, v)
	_build_hearts()
	_refresh()

func set_health(v: int) -> void:
	health = clamp(v, 0, max_hearts)
	_refresh()

func _build_hearts() -> void:
	# Borra todos los duplicados previos (dejamos la plantilla original)
	for child in get_children():
		if child != heart_template:
			child.queue_free()
	# Creamos max_hearts copias visibles
	for i in range(max_hearts):
		var tr := heart_template.duplicate() as TextureRect
		tr.visible = true
		tr.texture = heart_texture
		tr.custom_minimum_size = heart_template.custom_minimum_size
		add_child(tr)

func _refresh() -> void:
	# Muestra solo 'health' corazones, el resto se oculta
	print("hola")
	var idx := 0
	for child in get_children():
		if child == heart_template:
			continue
		child.visible = idx < health
		idx += 1

# helper
func set_max_and_health(new_max: int, new_health: int) -> void:
	_set_max_hearts(new_max)
	set_health(new_health)
