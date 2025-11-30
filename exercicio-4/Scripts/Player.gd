extends CharacterBody3D

@export var speed = 5.0
@export var rotation_speed = 2.0
@export var jump_velocity = 4.5

var gravity = ProjectSettings.get_setting("physics/3d/default_gravity")

func _physics_process(delta):
	# 1. Gravidade
	if not is_on_floor():
		velocity.y -= gravity * delta

	# 2. Rotação (Setas Esquerda/Direita)
	var rotation_direction = Input.get_axis("ui_right", "ui_left")
	if rotation_direction != 0:
		rotate_y(rotation_direction * rotation_speed * delta)

	# 3. Movimento (Setas Cima/Baixo)
	# Nota: Inverti a ordem aqui. "ui_up" agora retorna -1 (frente no Godot) e "ui_down" retorna 1
	var input_dir = Input.get_axis("ui_up", "ui_down")
	
	# transform.basis.z aponta para trás. Multiplicamos pelo input.
	# Se apertar Cima (-1) * tras (z) = Frente
	var direction = (transform.basis.z * input_dir).normalized()
	
	if direction:
		velocity.x = direction.x * speed
		velocity.z = direction.z * speed
	else:
		velocity.x = move_toward(velocity.x, 0, speed)
		velocity.z = move_toward(velocity.z, 0, speed)

	# DEBUG: Se apertar espaço, avisa no console se está no chão
	if Input.is_action_just_pressed("ui_accept"):
		print("Está no chão? ", is_on_floor(), " | Velocidade: ", velocity)

	move_and_slide()
