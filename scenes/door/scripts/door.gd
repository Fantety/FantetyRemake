extends AnimatableBody2D


var door_idx : get = get_door_idx, set = set_door_idx
var door_status = false

# Called when the node enters the scene tree for the first time.
func _ready():
	CommonSignal.call_change_door_status.connect(Callable(self,"change_door_status"))
	pass # Replace with function body.

func set_door_idx(idx):
	door_idx = idx
func get_door_idx()->Common.DoorIdx:
	return door_idx

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func change_door_status(idx, status):
	if idx == door_idx && status != door_status:
		if !$AudioStreamPlayer.is_playing():
			$AudioStreamPlayer.play()
			pass
		if status:
			$DoorSprite.play("default")
			$AnimationPlayer.play("default")
			door_status = status
		else:
			$DoorSprite.play_backwards("default")
			$AnimationPlayer.play_backwards("default")
			door_status = status
			pass
		pass
	pass


func _on_animation_player_animation_finished(anim_name):
	$AudioStreamPlayer.stop()
	pass # Replace with function body.
