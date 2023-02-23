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
	elif area_type == Common.Areas.BEDROOM_DESK:
		var dialog = load("res://dialogue/bedroom_desk.dialogue")
		DialogueManager.show_example_dialogue_balloon(dialog,"start")
		pass
	elif area_type == Common.Areas.BEDROOM_TERMINAL:
		var dialog = load("res://dialogue/bedroom_terminal.dialogue")
		DialogueManager.show_example_dialogue_balloon(dialog,"start")
		pass
	pass

func on_dialogue_selected(dialogue_type):
	if dialogue_type == Common.DialogueType.BEDROOM_BED_FIRST:
		var dialogue_species = CommonDialogue.dialogue_dic["1"]
		Common.show_tips(dialogue_species[0],dialogue_species[1])
	elif dialogue_type == Common.DialogueType.BEDROOM_DESK_FIRST:
		var dialogue_species = CommonDialogue.dialogue_dic["2"]
		Common.show_tips(dialogue_species[0],dialogue_species[1])
		CommonBackpack.backpack["装着水的杯子"] += 1
	elif dialogue_type == Common.DialogueType.BEDROOM_TERMINAL_NORMAL_USE_WATER:
		var dialogue_species = CommonDialogue.dialogue_dic["3"]
		Common.show_tips(dialogue_species[0],dialogue_species[1])
	pass
