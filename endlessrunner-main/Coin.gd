extends Node3D


func _ready() -> void:
	var anim = $AnimationPlayer.get_animation("CoinSpin")
	$AnimationPlayer.play("CoinSpin")
	anim.loop_mode = Animation.LOOP_LINEAR


func coin_collected(_body: Node3D):
	Event.emit_signal("player_collected_coin")
	queue_free()
