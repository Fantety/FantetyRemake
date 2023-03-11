extends AnimatableBody2D

var is_in_self = false
var elevator_ctrl_ui = load("res://scenes/elevator/elevator_ctrl.tscn")
# Called when the node enters the scene tree for the first time.
func _ready():
	$Lights/PointLight2D.set_color(Color(0,1,1,1))
	CommonSignal.call_reach_floor.connect(Callable(self,"do_reach_floor"))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !Common.input_lock:
		if Input.is_action_just_pressed("action") && is_in_self:
			if find_child("ElevatorCtrl",true,false) == null:
				add_child(elevator_ctrl_ui.instantiate())
			else:
				find_child("ElevatorCtrl",true,false).queue_free()
		pass
	pass


func do_reach_floor(floor):
	$Timer.start()
	if Common.elevator_current_floor == 4:
		CommonSignal.emit_signal("call_change_door_status",Common.DoorIdx.ELEVATOR_FOURTH_LEFT,false)
		CommonSignal.emit_signal("call_change_door_status",Common.DoorIdx.ELEVATOR_FOURTH_RIGHT,false)
	elif Common.elevator_current_floor == 3:
		CommonSignal.emit_signal("call_change_door_status",Common.DoorIdx.ELEVATOR_THRID_LEFT,false)
		CommonSignal.emit_signal("call_change_door_status",Common.DoorIdx.ELEVATOR_THRID_RIGHT,false)
	elif Common.elevator_current_floor == 2:
		CommonSignal.emit_signal("call_change_door_status",Common.DoorIdx.ELEVATOR_SECOND_LEFT,false)
		CommonSignal.emit_signal("call_change_door_status",Common.DoorIdx.ELEVATOR_SECOND_RIGHT,false)
	elif Common.elevator_current_floor == 1:
		CommonSignal.emit_signal("call_change_door_status",Common.DoorIdx.ELEVATOR_FIRST_LEFT,false)
		CommonSignal.emit_signal("call_change_door_status",Common.DoorIdx.ELEVATOR_FIRST_RIGHT,false)
		pass
	if CommonStatus.elevator_plot_status == false:
		var tween1 = create_tween().set_trans(Tween.TRANS_QUAD)
		tween1.tween_property(self,"position:y",get_position().y+(4-1)*32*4,1)
		$EleFall.play()
		tween1.play()
		await tween1.finished
		$EleCollision.play()
		CommonSignal.emit_signal("call_shake_camera",0.4)
		CommonSignal.emit_signal("call_elevator_fallen")
		Common.elevator_current_floor = 1
		return
	await $Timer.timeout
	$AnimatedSprite2D.play()
	$Start.play()
	$Lights/PointLight2D.set_color(Color(1,0,0.5,1))
	await $Start.finished
	$Run.play()
	var tween = create_tween().set_trans(Tween.TRANS_CUBIC)
	tween.tween_property(self,"position:y",get_position().y+(Common.elevator_current_floor-floor)*32*4,abs(Common.elevator_current_floor-floor)*2)
	tween.play()
	await tween.finished
	$Lights/PointLight2D.set_color(Color(0,1,1,1))
	$Run.stop()
	$Arrived.play()
	$AnimatedSprite2D.pause()
	Common.elevator_current_floor = floor
	CommonSignal.emit_signal("call_elevator_arrived",floor)
	pass


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		if CommonStatus.elevator_plot_status == false:
			CommonSignal.emit_signal("call_start_elevator_plot")
			CommonSignal.emit_signal("call_show_player_emo", Common.EmoType.AMAZED)
			pass
		else:
			CommonSignal.emit_signal("call_show_player_emo", Common.EmoType.DEFAULT)
		is_in_self = true
		pass
	pass # Replace with function body.

func _on_area_2d_body_exited(body):
	if body.name == "Player":
		is_in_self = false
		CommonSignal.emit_signal("call_hide_player_emo")
		pass
	pass # Replace with function body.


func _on_area_2d_area_entered(area):
	if area.name == "FourArea":
		$AnimatedSprite2D/AnimatedSprite2D.set_frame(3)
	if area.name == "ThreeArea":
		$AnimatedSprite2D/AnimatedSprite2D.set_frame(2)
	if area.name == "TwoArea":
		$AnimatedSprite2D/AnimatedSprite2D.set_frame(1)
	if area.name == "OneArea":
		$AnimatedSprite2D/AnimatedSprite2D.set_frame(0)
		pass
	pass # Replace with function body.
