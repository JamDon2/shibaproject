extends CharacterBody2D

signal out_of_bounds_left
signal out_of_bounds_right
signal player_hit(paddle: Player)
signal wall_hit

@export var initial_speed: float = 350.0
@export var speed_increment: float = 25.0

var current_speed: float
var direction: Vector2 = Vector2.ZERO

func _ready() -> void:
	reset_ball()

func _physics_process(delta: float) -> void:
	velocity = direction * current_speed
	var collision = move_and_collide(velocity * delta)
	
	if collision:
		direction = direction.bounce(collision.get_normal())

		var collider = collision.get_collider()
		
		var player_paddle := collider as Player

		if player_paddle:
			current_speed += speed_increment

			if collider.is_dashing:
				current_speed += 150.0
			
			player_hit.emit(player_paddle)
		else:
			wall_hit.emit()

func _process(_delta: float) -> void:
	var viewport_rect = get_viewport_rect()
	if position.x < 0:
		out_of_bounds_left.emit()
		reset_ball()
	if position.x > viewport_rect.size.x:
		out_of_bounds_right.emit()
		reset_ball()

func reset_ball() -> void:
	position = get_viewport_rect().size / 2
	current_speed = initial_speed
	
	direction = Vector2(
		[1, -1][randi() % 2],
		randf_range(-0.5, 0.5)
	).normalized()
