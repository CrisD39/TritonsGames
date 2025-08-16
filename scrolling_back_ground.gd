extends Node2D

@export var speed := 120.0
@onready var s1: Sprite2D = $S1
@onready var s2: Sprite2D = $S2
var tex_h := 0.0

func _ready() -> void:
	tex_h = s1.texture.get_height()
	s1.position = Vector2(0, 0)
	s2.position = Vector2(0, -tex_h)   # arriba de S1

func _process(delta: float) -> void:
	s1.position.y += speed * delta
	s2.position.y += speed * delta

	# Cuando uno sale por abajo, lo reubico justo arriba del otro
	if s1.position.y >= tex_h:
		s1.position.y = s2.position.y - tex_h
	if s2.position.y >= tex_h:
		s2.position.y = s1.position.y - tex_h
extends Node2D
