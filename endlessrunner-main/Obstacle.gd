extends Node3D


func obstacle_hit(_body: Node3D):
	if _body is CharacterBody3D and _body.position.x >= 20:
		Event.emit_signal("player_lost_health")
