extends Node3D

@export var scenes: Array[PackedScene]
@onready var old_node
@onready var new_node
@onready var interface = $Control/Panel/RichTextLabel
var coins_collected := 0


func _ready() -> void:
	old_node = scenes.pick_random().instantiate()
	add_child(old_node)
	
	Event.connect("player_entered_tile", spawn_next)
	Event.connect("player_collected_coin", coin_slots)
	Event.connect("player_died", game_over)
	Event.connect("player_lost_health", change_player_health)


func spawn_next() -> void:
	new_node = scenes.pick_random().instantiate()
	new_node.position.x = $Player.position.x + 30
	add_child(new_node)


func coin_slots() -> void:
	coins_collected += 1
	$AudioStreamPlayer.play()
	interface.text = "Coins Collected: %s" % coins_collected


func game_over() -> void:
	$Control/GameOver.visible = true
	$MusicPlayer.stop()
	$Control/GameOver/AudioStreamPlayer.play()
	$Player.queue_free()


func play_again() -> void:
	get_tree().reload_current_scene()


func change_player_health() -> void:
	$Player.health_bars(-1)
	$HurtSound.play()
	for i in $Control/Panel/HBoxContainer.get_child_count():
		if i >= $Player.HEALTH_POINTS:
			$Control/Panel/HBoxContainer.get_child(i).visible = false
