extends CharacterBody2D


var speed =50.0
const JUMP_VELOCITY = -200.0

# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_jumped = false

func _ready():
	$Emo.hide()
	CommonSignal.call_show_player_emo.connect(Callable(self,"show_player_emo"))
	CommonSignal.call_hide_player_emo.connect(Callable(self,"hide_player_emo"))

func _physics_process(delta):
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	# Handle Jump.
	if is_jumped && is_on_floor():
		if !$JumpSound.is_playing():
			$JumpSound.play()
		is_jumped = false
	if !Common.input_lock:
		if Input.is_action_just_pressed("ui_jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
			is_jumped = true
		var direction = Input.get_axis("ui_left", "ui_right")
		if direction:
			if speed <= 150:
				speed += 200*delta
			if !$RunSound.is_playing():
				$RunSound.play()
			velocity.x = direction * speed
			$AnimatedSprite2D.play("run")
			if direction < 0:
				$AnimatedSprite2D.set_flip_h(true)
			else:
				$AnimatedSprite2D.set_flip_h(false)
		else:
			$AnimatedSprite2D.play("stand")
			$RunSound.stop()
			velocity.x = move_toward(velocity.x, 0, speed)
			speed = 50.0
		move_and_slide()

func show_player_emo(emo_type):
	$Emo.show()
	if emo_type == Common.EmoType.AMAZED:
		$Emo.play("amazed")
	elif emo_type == Common.EmoType.DEFAULT:
		$Emo.play("default")
	elif emo_type == Common.EmoType.QUERY:
		$Emo.play("query")
	pass
func hide_player_emo():
	$Emo.hide()
