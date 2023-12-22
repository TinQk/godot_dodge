extends CanvasLayer

### SIGNALS (we can write them later)
signal start_game # the signal that will be produced when pushing the button (see function later)


# Called when the node enters the scene tree for the first time.
func _ready():
	hide_hud_control()
	show_start_menu()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


### MENU

func hide_hud_control():
	$TimeLabel.hide()
	$ScoreLabel.hide()
	$Message.hide()
	$StartButton.hide()

func show_start_menu():
	$Message.text = "Dodge the creeps !"
	$Message.show()
	
	# Make a one-shot timer and wait for it to finish.
	await get_tree().create_timer(1).timeout
	$StartButton.show()

func _on_StartButton_pressed():
	show_temp_message("Get ready...", 1)
	$StartButton.hide()
	update_time(0)
	update_score(0)
	$TimeLabel.show()
	$ScoreLabel.show()
	emit_signal("start_game")
	

func show_game_over():
	show_temp_message("Game Over", 4) # message temporaire 4 secondes
	
	await get_tree().create_timer(4).timeout
	$TimeLabel.hide()
	$ScoreLabel.hide()
	
	await get_tree().create_timer(1).timeout
	show_start_menu()


### MESSAGES

func show_temp_message(text, duration = 2):
	$Message.text = text
	$Message.show()
	$MessageTimer.wait_time = duration
	$MessageTimer.start()

func _on_MessageTimer_timeout():
	$Message.hide()


### SCORE

func update_score(score):
	$ScoreLabel.text = str(score)

func update_time(time):
	$TimeLabel.text = str(time)
