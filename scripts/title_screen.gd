extends Control

const MAIN_GAME_SCENE = preload("res://scenes/game.tscn")

@onready var start_button = $StartButton

func _ready():
	start_button.grab_focus.call_deferred()

func _on_start_pressed() -> void:
	get_tree().change_scene_to_packed(MAIN_GAME_SCENE)
