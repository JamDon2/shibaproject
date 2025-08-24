class_name Player

extends AnimatableBody2D

@export var player_id: int = 1
@export var paddle_color: Color = Color.WHITE

@export var speed: float = 300.0
@export var dash_speed: float = 1200.0
@export var dash_duration: float = 0.15

var is_dashing: bool = false
var dash_timer: float = 0.0

func _ready() -> void:
	$ColorRect.color = paddle_color

func _physics_process(delta: float) -> void:
	var current_move_speed = speed
	
	if is_dashing:
		dash_timer -= delta
		current_move_speed = dash_speed
		if dash_timer <= 0:
			is_dashing = false
	
	var move_direction = Input.get_axis(
		"p" + str(player_id) + "_up",
		"p" + str(player_id) + "_down"
	)
	
	if Input.is_action_just_pressed("p" + str(player_id) + "_dash") and not is_dashing:
		is_dashing = true
		dash_timer = dash_duration

	position.y += move_direction * current_move_speed * delta
	
	var viewport_height = get_viewport_rect().size.y
	var paddle_height = get_node("ColorRect").size.y
	position.y = clamp(position.y + move_direction * current_move_speed * delta, paddle_height / 2, viewport_height - paddle_height / 2)

func on_ball_hit() -> void:
	var tween: Tween = create_tween()
	tween.tween_property($ColorRect, "scale", Vector2(1.2, 0.8), 0.1)
	tween.tween_property($ColorRect, "scale", Vector2(1.0, 1.0), 0.1)
