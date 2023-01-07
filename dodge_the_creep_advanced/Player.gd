extends Area2D

signal hit #signale les collisions

export var speed = 400 # export ajoute la variable aux propriétés du node pour pouvoir la changer manuellement
var screen_size
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	screen_size = get_viewport_rect().size
	hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	var velocity = Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		velocity.x += 1
	if Input.is_action_pressed("move_left"):
		velocity.x -= 1
	if Input.is_action_pressed("move_up"):
		velocity.y -= 1
	if Input.is_action_pressed("move_down"):
		velocity.y += 1
		
	if velocity.length() > 0:
		velocity = velocity.normalized() * speed
		$AnimatedSprite.play() # ou get_node("AnimatedSprite").play()
	else:
		$AnimatedSprite.stop()
	
	# Update position
	position += velocity * delta
	
	# prevent it from leaving the screen:
	position.x = clamp(position.x, 0, screen_size.x)
	position.y = clamp(position.y, 0, screen_size.y)

	# Animation
	if velocity.y != 0:
		$AnimatedSprite.animation = "up"
		$AnimatedSprite.flip_v = velocity.y > 0
	
	elif velocity.x != 0:
		$AnimatedSprite.animation = "walk"
		$AnimatedSprite.flip_h = velocity.x < 0


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
	
	
