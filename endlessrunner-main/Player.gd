extends CharacterBody3D


@export var SPEED := 15.0
@export var HEALTH_POINTS := 3
const JUMP_VELOCITY = 5.0


func _ready() -> void:
	$Human/AnimationPlayer.speed_scale = 2


func _physics_process(delta: float) -> void:
	if not is_on_floor():
		velocity += get_gravity() * delta

	if Input.is_action_just_pressed("Jump") and is_on_floor():
		velocity.y = JUMP_VELOCITY

	var go_left := Input.is_action_just_released("Left")
	var go_right := Input.is_action_just_released("Right")
	if go_left or go_right:
		position.z += -1 if go_left else 1
		$Woosh.play()

	if is_on_floor():
		$Human/AnimationPlayer.play("ArmatureAction_001")
	
	if position.y <= -5:
		Event.emit_signal("player_died")
		queue_free()
	
	velocity.x = SPEED
	move_and_slide()


func health_bars(i: int) -> void:
	HEALTH_POINTS += i
	if HEALTH_POINTS <= 0:
		Event.emit_signal("player_died")
