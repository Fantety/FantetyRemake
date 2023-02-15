extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	CommonSignal.call_elevator_arrived.connect(Callable(self,"elevator_arrived_open_door"))
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func elevator_arrived_open_door(floor):
	if floor == 4:
		CommonSignal.emit_signal("call_change_door_status",Common.DoorIdx.ELEVATOR_FOURTH_LEFT,true)
		CommonSignal.emit_signal("call_change_door_status",Common.DoorIdx.ELEVATOR_FOURTH_RIGHT,true)
	elif floor == 3:
		CommonSignal.emit_signal("call_change_door_status",Common.DoorIdx.ELEVATOR_THRID_LEFT,true)
		CommonSignal.emit_signal("call_change_door_status",Common.DoorIdx.ELEVATOR_THRID_RIGHT,true)
	elif floor == 2:
		CommonSignal.emit_signal("call_change_door_status",Common.DoorIdx.ELEVATOR_SECOND_LEFT,true)
		CommonSignal.emit_signal("call_change_door_status",Common.DoorIdx.ELEVATOR_SECOND_RIGHT,true)
	elif floor == 1:
		CommonSignal.emit_signal("call_change_door_status",Common.DoorIdx.ELEVATOR_FIRST_LEFT,true)
		CommonSignal.emit_signal("call_change_door_status",Common.DoorIdx.ELEVATOR_FIRST_RIGHT,true)
	pass
