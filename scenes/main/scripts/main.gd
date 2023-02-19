extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	CommonSignal.call_elevator_arrived.connect(Callable(self,"elevator_arrived_open_door"))
	CommonSignal.call_show_dialogue.connect(Callable(self,"show_area_dialogue"))
	pass # Replace with function body.


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


func show_area_dialogue(area_type):
	if area_type == Common.Areas.BEDROOM_BED:
		var dialog = load("res://dialogue/bedroom_bed.dialogue")
		DialogueManager.show_example_dialogue_balloon(dialog,"start")
		pass
	pass

func on_dialogue_selected(dialogue_type):
	if dialogue_type == Common.DialogueType.BEDROOM_BED_FIRST:
		Common.show_tips("神秘纸条","想出去吗，但是要注意外面\n电压不稳定的情况下门是可以撞开的")
	pass
