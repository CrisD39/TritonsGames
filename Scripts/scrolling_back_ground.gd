extends ParallaxBackground

@export var speed: float = 120.0

@onready var layer1: ParallaxLayer = $ParallaxLayer
@onready var sprite: Sprite2D = $ParallaxLayer/sea

func _ready() -> void:
	# Configuro el mirroring en base al tamaño real de la textura
	var tex_size = sprite.texture.get_size()
	layer1.motion_mirroring = Vector2(tex_size.x, tex_size.y)

func _process(delta: float) -> void:
	scroll_offset.y += speed * delta   # desplaza la textura hacia abajo
