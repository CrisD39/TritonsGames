# enemy_base.gd
extends CharacterBody2D
class_name EnemyBase

@export var max_hp: int = 50
@export var speed: float = 100.0
@export var target_path: NodePath = ^"../Player"  # editable desde el editor

signal died(point: int)

@export var points: int = 100

var hp: int
var target: Node2D

func _ready() -> void:
	hp = max_hp
	if not target and target_path != NodePath():
		var n := get_node_or_null(target_path)
		if n is Node2D:
			target = n
	_on_ready() # hook opcional para hijos

func _physics_process(delta: float) -> void:
	if target:
		var dir: Vector2 = (target.global_position - global_position).normalized()
		velocity = dir * speed
		look_at(dir)
		rotation = dir.angle() + 45
		move_and_slide()
	else:
		var dir: Vector2 = Vector2.DOWN.normalized()
		velocity = dir * speed
		move_and_slide()
	
	if(global_position.y > 750):
		died.emit(0)
		queue_free()
		 
	_on_physics_process(delta) # hook opcional para hijos

func apply_damage(amount: int, from: Node) -> void:
	hp -= amount
	if hp <= 0:
		die(from)
	else:
		on_hurt(amount, from)  # hook

func die(from: Node) -> void:
	on_die(from)  # hook
	died.emit(points) 


# ---------- Hooks para sobreescribir en clases hijas ----------
func _on_ready() -> void:
	pass

func _on_physics_process(delta: float) -> void:
	pass

func on_hurt(amount: int, from: Node) -> void:
	pass

func on_die(from: Node) -> void:
	pass
