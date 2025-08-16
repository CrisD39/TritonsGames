extends EnemyBase


func on_die(from: Node) -> void:
	print("morir animacion")
	scale.x = 0.3
	scale.y = 0.3
	$AnimatedSprite2D.play("morir")
	$AudioStreamPlayer2D.play()
	await get_tree().create_timer(1).timeout
	queue_free()
