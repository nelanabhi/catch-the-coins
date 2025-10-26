extends Node2D

var score = 0
var time_left = 30  # total game time in seconds

func _ready():
	# Connecting the timers
	$SpawnTimer.connect("timeout", Callable(self, "_spawn_coin"))
	$GameTimer.connect("timeout", Callable(self, "_on_game_timer_timeout"))

	#  initial label text
	$ScoreLabel.text = "Score: 0"
	$TimerLabel.text = "Time: %d" % time_left

	# background music is here
	if has_node("MusicPlayer"):
		$MusicPlayer.play()

func _spawn_coin():
	var coin_scene = preload("res://scenes/coin.tscn")
	var coin = coin_scene.instantiate()
	coin.position = Vector2(randi_range(50, 430), -20)
	add_child(coin)
	coin.connect("caught", Callable(self, "_on_coin_caught"))
	print("Spawning coin")

func _on_coin_caught():
	score += 1
	$ScoreLabel.text = "Score: %d" % score

func _on_game_timer_timeout():
	time_left -= 1
	$TimerLabel.text = "Time: %d" % time_left

	if time_left <= 0:
		_game_over()

func _game_over():
	$SpawnTimer.stop()
	$GameTimer.stop()

	if has_node("MusicPlayer"):
		$MusicPlayer.stop()

	$GameOverLabel.visible = true
	print("Game Over!")

#  restarting the game by pressing Space or Enter
func _process(_delta):
	if $GameOverLabel.visible and Input.is_action_just_pressed("ui_accept"):
		get_tree().reload_current_scene()
