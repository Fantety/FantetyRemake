extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Door.set_door_idx(Common.DoorIdx.ELEVATOR_THRID_RIGHT)
	$Door2.set_door_idx(Common.DoorIdx.ELEVATOR_THRID_LEFT)
	pass # Replace with function body.


