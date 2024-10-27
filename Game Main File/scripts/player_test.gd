extends CharacterBody2D

const SPEED = 150.0
const JUMP_VELOCITY = -380.0
@onready var animation: AnimatedSprite2D = $animation
@export var nextLevel: PackedScene
@onready var current_level = get_tree().current_scene.name	
var is_alive = true
var is_dying = false


# die animation (can't work now)
#func _on_body_entered(body: Node2D) -> void:
	#if body.is_in_group("slime") and body.is.alive:
		#is_alive = false
		#die()

#func die():
	#if is_dying:
		#return
		#
	#is_dying = true
	#animation.play("die")		
	#await move_player_up_and_down()
	#get_tree().reload_current_scene()
	#
#func move_player_up_and_down():
	#var start_position = position
	#var up_position = start_position + Vector2(0, -100)
	#var down_position = start_position + Vector2(0, 600)
	#
	#while position.y > up_position.y:
		#position.y -= 4
		#await get_tree().create_timer(0.01).timeout
		


func _physics_process(delta: float) -> void:
	if is_dying:
		return

	# Add the gravity.
	if not is_on_floor():
		velocity += get_gravity() * delta


	# Handle jump.
	if Input.is_action_just_pressed("jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	# Get the input direction =-1, 0, 1
	var direction := Input.get_axis("move_left", "move_right")
	
	#flip the sprite
	if direction > 0 :
		animation.flip_h = false
	elif direction < 0:
		animation.flip_h = true
	
	# play animation
	if is_dying:
		return
	
	if is_on_floor():
		if direction == 0 :
			animation.play("idle")
		else:
			animation.play("walk")
	else:
		animation.play("jump")


	
	# apply movement
	if direction:
		velocity.x = direction * SPEED
	else:
		velocity.x = move_toward(velocity.x, 0, SPEED)

	move_and_slide()
	
# win zone
func _on_body_entered(_body: Node2D) -> void:
	if current_level == "Level1":
		animation.play("guitar")
	elif current_level == "Level2":
		animation.play("flute")
	elif current_level == "Level3":
		animation.play("piano")	
