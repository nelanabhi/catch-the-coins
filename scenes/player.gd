extends CharacterBody2D

@export var speed := 300.0
@export var left_bound := 16.0
@export var right_bound := 464.0

func _physics_process(_delta):
	var direction := Input.get_axis("move_left", "move_right")

	velocity.x = direction * speed
	velocity.y = 0
	move_and_slide()

	# Keep on screen 
	position.x = clamp(position.x, left_bound, right_bound)

	# DEBUG CODE 
	if direction != 0:
		print("dir = ", direction, "  x = ", position.x)
