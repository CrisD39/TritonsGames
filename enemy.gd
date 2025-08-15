# enemy_a.gd

extends CharacterBody2D

@export var max_hp := 50
var hp := max_hp

@onready var speed = 300
var target: Node2D

func _ready() -> void:
	target = get_parent().get_node("Player") # Ajusta el nombre si es distinto

func _physics_process(delta: float) -> void:
	if target:
		var direction: Vector2 = target.global_position - global_position
		velocity = direction.normalized() * speed
		move_and_slide()
		
func apply_damage(amount: int, from: Node) -> void:
	hp -= amount
	if hp <= 0:
		queue_free()  # o anim de muerte
