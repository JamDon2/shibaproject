extends Camera2D

func shake(duration, strength):
	var tween = create_tween()
	tween.tween_method(Callable(self, "_apply_shake"), 0.0, strength, duration)
	tween.tween_property(self, "offset", Vector2.ZERO, 0.1).set_trans(Tween.TRANS_SINE)

func _apply_shake(strength):
	offset = Vector2(randf_range(-strength, strength), randf_range(-strength, strength))
