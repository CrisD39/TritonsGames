extends Area2D

@export var velocidad = 500
@onready var recorrido_max = 1000
@onready var distancia = 0


func _physics_process(delta: float) -> void:
	var direction = Vector2.UP.rotated(rotation)  # Dirección hacia arriba con rotación
	position += direction * velocidad * delta  # Mover el objeto en la dirección calculada
	distancia += velocidad * delta  # Incrementar la distancia recorrida
	if distancia >= recorrido_max:
		queue_free()  # Eliminar el objeto cuando alcance el recorrido máximo
