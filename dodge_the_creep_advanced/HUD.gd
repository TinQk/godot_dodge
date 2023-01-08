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
	$ScoreLabel.hide()
	$Message.hide()
	$StartButton.hide()

func show_start_menu():
	$Message.text = "Dodge the creeps !"
	$Message.show()
	
	# Make a one-shot timer and wait for it to finish.
	yield(get_tree().create_timer(1), "timeout")
	$StartButton.show()

func _on_StartButton_pressed():
	$Message.hide()
	$StartButton.hide()
	update_score(0)
	$ScoreLabel.show()
	emit_signal("start_game")
	

func show_game_over():
	show_temp_message("Game Over", 4) # message temporaire 4 secondes
	
	yield(get_tree().create_timer(4), "timeout")
	$ScoreLabel.hide()
	
	yield(get_tree().create_timer(1), "timeout")
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
