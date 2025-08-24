extends Node2D

@onready var score_label: Label = $ScoreLabel
@onready var ball: CharacterBody2D = $Ball
@onready var player1: Player = $Player1
@onready var player2: Player = $Player2

var score_p1: int = 0
var score_p2: int = 0

func _ready() -> void:
	update_score_display()

func update_score_display() -> void:
	score_label.text = str(score_p1) + " - " + str(score_p2)

func _on_ball_out_of_bounds_left() -> void:
	$Camera2D.shake(0.1, 15)
	score_p2 += 1
	update_score_display()

func _on_ball_out_of_bounds_right() -> void:
	$Camera2D.shake(0.1, 15)
	score_p1 += 1
	update_score_display()

func _on_player_hit(paddle: Player) -> void:
	if paddle == player1:
		player1.on_ball_hit()
	elif paddle == player2:
		player2.on_ball_hit()

func _on_wall_hit() -> void:
	$Camera2D.shake(0.1, 5)
