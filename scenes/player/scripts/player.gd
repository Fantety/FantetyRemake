extends CharacterBody2D


var current_area = Common.Areas.NONE

var speed =100.0
const JUMP_VELOCITY = -200.0

var speed_limit = 200.0
var speed_scale_limit  =1.5
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")
var is_jumped = false
var is_sprint = false

var tick = 0.0
var tick_count = 0.01

func _ready():
	$Emo.hide()
	CommonSignal.call_show_player_emo.connect(Callable(self,"show_player_emo"))
	CommonSignal.call_hide_player_emo.connect(Callable(self,"hide_player_emo"))
	CommonSignal.call_change_player_area.connect(Callable(self,"change_current_area"))



func _physics_process(delta):
	if tick > tick_count:
		tick = 0.0
		CommonSignal.emit_signal("call_player_velocity",velocity)
	else:
		tick += delta
	# Add the gravity.
	if not is_on_floor():
		velocity.y += gravity * delta
	# Handle Jump.
	if is_jumped && is_on_floor():
		if !$JumpSound.is_playing():
			$JumpSound.play()
		is_jumped = false
	if !Common.input_lock:
		if is_sprint:
			if is_on_wall():
				CommonSignal.emit_signal("call_shake_camera",0.2)
				if !$Sprint.is_playing():
					$Sprint.play() 
				CommonSignal.emit_signal("call_player_collision_occured")
				pass
		if absf(velocity.x) >= 250.0:
			is_sprint = true
		else:
			is_sprint = false
		if Input.is_action_just_pressed("speed_up"):
			speed_limit = 300.0
			speed_scale_limit = 2.0
		if Input.is_action_just_released("speed_up"):
			speed_limit = 200.0
			speed_scale_limit = 1.5
		if Input.is_action_just_pressed("action") and current_area != Common.Areas.NONE:
			CommonSignal.emit_signal("call_show_dialogue",current_area)
			pass
		if Input.is_action_just_pressed("ui_jump") and is_on_floor():
			velocity.y = JUMP_VELOCITY
			is_jumped = true
		var direction = Input.get_axis("ui_left", "ui_right")
		if direction:
			if speed <= speed_limit:
				speed += 100*delta
			if $AnimatedSprite2D.speed_scale <=speed_scale_limit:
				$AnimatedSprite2D.speed_scale += 20*delta
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
			speed = 100.0
			$AnimatedSprite2D.speed_scale = 1.0
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

func change_current_area(area_type):
	current_area = area_type
	pass


func _on_area_2d_area_entered(area):
	CommonSignal.emit_signal("call_player_enter_area",area.name)
	pass # Replace with function body.


func _on_area_2d_area_exited(area):
	CommonSignal.emit_signal("call_player_exit_area",area.name)
	pass # Replace with function body.
