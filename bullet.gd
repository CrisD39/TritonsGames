# bullet.gd (la bala ES un Area2D)
extends Area2D

@export var speed := 100
@export var damage := 10

var direction := Vector2.UP

func _ready() -> void:
	# Asegurate de que Collision > Monitoring esté activo y layers/masks bien seteados
	area_entered.connect(_on_area_entered)

func _physics_process(delta: float) -> void:
	global_position += direction * speed * delta

func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("hurtbox"):
		var enemy := area.get_parent()
		if enemy and enemy.has_method("apply_damage"):
			enemy.apply_damage(damage, self)
		# Evitar múltiples impactos en el mismo frame
		set_deferred("monitoring", false)
		queue_free()
