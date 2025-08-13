extends CharacterBody2D

@onready var speed = 300
var target

func _ready() -> void:
	target = get_parent().get_node("Player")

func _physics_process(delta: float) -> void:
	pass
	#if target:
		#var direction = target.global_position - global_position
		#direction = direction.normalized()
		#velocity = direction * speed
		#move_and_slide()
