extends Node # le type de scene (ici c'est basique)


# allow to chose the scenes we want to instance:
export(PackedScene) var mob_scene


# variables
var score # le score du joueur
var screen_size


### INIT
# Called when the node enters the scene tree for the first time.
func _ready():
	randomize() # permet d'avoir un seed different pour le random
	# le HUD est appelé de base car c'est un enfant


### RUNNING
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass




### FUNCTIONS

# On lance le jeu quand on appui sur start
func _on_HUD_start_game():
	new_game()

func new_game():
	score = 0
	$Player.start($StartPosition.position)
	$StartTimer.start()

func _on_StartTimer_timeout():
	$MobTimer.start()
	$ScoreTimer.start()

func game_over():
	$ScoreTimer.stop()
	$MobTimer.stop()
	$HUD.show_game_over()


### SCORE

func _on_ScoreTimer_timeout():
	score += 1
	$HUD.update_score(score)


### MOB GENERATION

func _on_MobTimer_timeout():
	# Créer une nouvelle instance de mob
	var mob = mob_scene.instance()
	
	# Choose a random location on Path2D.
	var mob_spawn_location = get_node("MobPath/MobSpawnLocation")
	mob_spawn_location.offset = randi()

	# Set the mob's position to this location.
	mob.position = mob_spawn_location.position

	# Set the mob's direction perpendicular to the path direction.
	var direction = mob_spawn_location.rotation + PI / 2
	direction += rand_range(-PI / 4, PI / 4) # Add some randomness to the direction.
	mob.rotation = direction

	# Choose the velocity for the mob.
	var velocity = Vector2(rand_range(150.0, 250.0), 0.0)
	mob.linear_velocity = velocity.rotated(direction)

	# Spawn the mob by adding it to the Main scene.
	add_child(mob)






