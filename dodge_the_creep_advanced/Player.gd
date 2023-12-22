extends Area2D

signal hit #signale les collisions

@export var speed = 400 # export ajoute la variable aux propriétés du node pour pouvoir la changer manuellement
var screen_size


### INIT
# Called when the node enters the scene tree for the first time.
func _ready():
	hide() # Cacher le joueur tant que le jeu n'a pas démarré
	screen_size = get_viewport_rect().size


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	
	# Changer la direction du mouvement en fonction des touches appuyées
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
	
	# normalisation de la vitesse et declenchement de l'animation du sprite pendant le mouvement
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite2D.play() # ou get_node("AnimatedSprite2D").play()
	else:
		$AnimatedSprite2D.stop()
	
	# Update position
	position += velocity * delta
	
	# prevent it from leaving the screen:
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

	# Paramètres de l'animation
	if velocity.y != 0:
		$AnimatedSprite2D.animation = "up"
		$AnimatedSprite2D.flip_v = velocity.y > 0
	
	elif velocity.x != 0:
		$AnimatedSprite2D.animation = "walk"
		$AnimatedSprite2D.flip_h = velocity.x < 0


# Gérer l'impact avec un ennemi
func _on_Player_body_entered(body):
	hide() # disapear when touched
	emit_signal("hit")
	$CollisionShape2D.set_deferred("disabled", true) # set deferred pour éviter certaines erreures (bas niveau)


# Fonction d'initialisation	
func start(pos):
	position = pos 
	show()
	$CollisionShape2D.disabled = false
	
	
