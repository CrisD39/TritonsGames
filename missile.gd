extends Area2D

@export var speed := 300
@export var damage := 100
@onready var fuego = $CPUParticles2D

var direction : Vector2 
var target := Node2D

func _ready() -> void:
	# Asegurate de que Collision > Monitoring esté activo y layers/masks bien seteados
	area_entered.connect(_on_area_entered)

func _physics_process(delta: float) -> void:
	if target:
		direction = (target.global_position - global_position).normalized()
		rotation = direction.angle() + 90
		global_position += direction * speed * delta
		fuego.angular_velocity_max = rotation
		fuego.angular_velocity_min = rotation
		fuego.angle_max = rotation
		fuego.angle_min = rotation
		
func _on_area_entered(area: Area2D) -> void:
	if area.is_in_group("hurtbox"):
		var enemy := area.get_parent()
		if enemy and enemy.has_method("apply_damage"):
			enemy.apply_damage(damage, self)
		# Evitar múltiples impactos en el mismo frame
		set_deferred("monitoring", false)
		queue_free()
		
