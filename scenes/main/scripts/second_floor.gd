extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Door.set_door_idx(Common.DoorIdx.ELEVATOR_SECOND_RIGHT)
	$Door2.set_door_idx(Common.DoorIdx.ELEVATOR_SECOND_LEFT)
	$Door/DoorCtrlIn.set_door_permission(Common.DoorPermission.ELEVATOR_ADMIT)
	$Door2/DoorCtrlOut.set_door_permission(Common.DoorPermission.ELEVATOR_ADMIT)
	pass # Replace with function body.

