extends AnimatableBody2D


var door_idx : get = get_door_idx, set = set_door_idx
var door_status:bool = false
var is_occured = false
var is_stable = true


# Called when the node enters the scene tree for the first time.
func _ready():
	CommonSignal.call_change_door_status.connect(Callable(self,"change_door_status"))
	CommonSignal.call_player_collision_occured.connect(Callable(self,"change_door_occured_status"))
	pass # Replace with function body.

func set_door_idx(idx):
	door_idx = idx
func get_door_idx()->Common.DoorIdx:
	return door_idx

func change_door_status(idx, status):
	if idx == door_idx && status != door_status:
		if !$AudioStreamPlayer.is_playing():
			$AudioStreamPlayer.play()
			pass
		if status:
			$DoorSprite.play("default")
			$AnimationPlayer.play("default")
			door_status = status
			for i in get_children(false):
				if i.name.contains("DoorCtrl"):
					i.set_frame(1)
			await $AnimationPlayer.animation_finished
			$CollisionShape2D.set_deferred("disabled",true)
		else:
			$DoorSprite.play_backwards("default")
			$AnimationPlayer.play_backwards("default")
			door_status = status
			for i in get_children(false):
				if i.name.contains("DoorCtrl"):
					i.set_frame(0)
			$CollisionShape2D.set_deferred("disabled",false)

func _on_animation_player_animation_finished(anim_name):
	$AudioStreamPlayer.stop()
	pass # Replace with function body.

func change_door_occured_status():
	if get_door_idx()==Common.DoorIdx.BEDROOM:
		is_occured = true

func _on_sprint_area_body_entered(body):
	if body.name == "Player" \
	and is_occured == true \
	and get_door_idx()==Common.DoorIdx.BEDROOM \
	and !is_stable:
		var collision_value = randi_range(0,9)
		print_debug("[碰撞门",get_door_idx(), "]:", collision_value )
		if collision_value >= 6:
			change_door_status(get_door_idx(),true)
		is_occured = false
	pass # Replace with function body.


func _on_sprint_area_body_exited(body):
	if body.name == "Player":
		is_occured = false
	pass # Replace with function body.
