extends Node2D

var Ship = preload("res://Scenes/Ship.tscn")
var Bomb = preload("res://Scenes/Bomb.tscn")
var Enemy = preload("res://Scenes/Enemy.tscn")
var Explosion = preload("res://Scenes/Explosion.tscn")
var score = 0
var is_game_over = false
var is_paused = false
var screensize

func _ready():
	screensize = get_viewport_rect().size
	$GameOver.visible = false
	$Paused.visible = false

func _process(delta):
	if is_game_over:
		if Input.is_action_just_pressed("ui_accept"):
			_reset()
	if is_paused:
		if Input.is_action_just_pressed("space"):
			pass

func _reset():
	score = 0
	$Score.text = str(score)
	var ship = Ship.instance()
	ship.position = Vector2(screensize.y - 20, screensize.x / 2)
	add_child(ship)
	$GameOver.visible = false
	is_game_over = false
	$Paused.visible = false
	is_paused = false

func change_score(pts):
	score += pts
	$Score.text = str(score)

func game_over():
	is_game_over = true
	$GameOver.visible = true
	$Music.stop()

func paused():
	is_paused = true
	$Paused.visible = true
	$Music.stop()

func new_explosion(pos):
	var explosion = Explosion.instance()
	explosion.position = pos
	add_child(explosion)

func new_bomb(pos):
	var bomb = Bomb.instance()
	bomb.position = pos
	add_child(bomb)




func _on_EnemyTimer_timeout():
	if is_game_over:
		return
	var enemy = Enemy.instance()
	add_child(enemy)
	$EnemyTimer.wait_time = (randi() % 2) + 1
	$EnemyTimer.start()
