extends Area2D

signal caught

func _process(delta):
	position.y += 100 * delta
	if position.y > 600:
		queue_free()

func _on_body_entered(body):
	if body.name == "Player":
		emit_signal("caught")
		queue_free()
