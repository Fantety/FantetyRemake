extends AnimatedSprite2D


@export var connected_door:NodePath
var is_in_self = false
var door_status = false

var tick_count = 0.01
var tick = 0.0
# Called when the node enters the scene tree for the first time.
func _ready():
	$TextureProgressBar.hide()
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if !Common.input_lock && is_in_self:
		if Input.is_action_just_pressed("action"):
			if door_status == true:
				change_door()
			else:
				$TextureProgressBar.show()
		if Input.is_action_just_released("action"):
			$TextureProgressBar.hide()
			$TextureProgressBar.set_value(0.0)
			$Input.stop()
		if Input.is_action_pressed("action") && door_status == false:
			if !$Input.is_playing():
				$Input.play()
			if tick > tick_count:
				tick = 0.0
				$TextureProgressBar.set_value($TextureProgressBar.get_value()+1)
			else:
				tick += delta
		pass
	pass

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		is_in_self = true
	pass # Replace with function body.


func _on_area_2d_body_exited(body):
	if body.name == "Player":
		is_in_self = false
	pass # Replace with function body.

func change_door():
	door_status = !door_status
	CommonSignal.emit_signal("call_change_door_status",get_node(connected_door).get_door_idx(),door_status)
	if door_status:
		set_frame(1)
	else:
		set_frame(0)



func _on_texture_progress_bar_value_changed(value):
	if value == 100:
		$TextureProgressBar.hide()
		$TextureProgressBar.set_value(0.0)
		if !$InputRight.is_playing():
				$InputRight.play()
		change_door()
	pass # Replace with function body.
