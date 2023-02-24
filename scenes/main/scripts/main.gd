extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	var tween = create_tween().set_trans(Tween.TRANS_LINEAR)
	tween.tween_property($WorldEnvironment,"environment:adjustment_brightness",1.0,2)
	tween.play()
	await tween.finished
	Common.input_lock = false
	CommonSignal.call_elevator_arrived.connect(Callable(self,"elevator_arrived_open_door"))
	CommonSignal.call_show_dialogue.connect(Callable(self,"show_area_dialogue"))
	CommonSignal.call_door_is_unstable.connect(Callable(self,"on_recv_door_unstable"))
	CommonSignal.call_player_enter_ray.connect(Callable(self,"coma"))
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
	elif area_type == Common.Areas.BEDROOM_SOFA:
		var dialog = load("res://dialogue/bedroom_sofa.dialogue")
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
		Common.acquire_item("装着水的杯子")
	elif dialogue_type == Common.DialogueType.BEDROOM_TERMINAL_NORMAL_USE_WATER:
		var dialogue_species = CommonDialogue.dialogue_dic["3"]
		Common.show_tips(dialogue_species[0],dialogue_species[1])
	elif dialogue_type == Common.DialogueType.BEDROOM_SOFA_FIRST:
		var dialogue_species = CommonDialogue.dialogue_dic["4"]
		Common.show_tips(dialogue_species[0],dialogue_species[1])
		Common.acquire_item("螺丝刀")
	elif dialogue_type == Common.DialogueType.BEDROOM_TERMINAL_APRANCE_BROKEN_USE_WATER:
		Common.show_progress_bar("正在向控制终端终灌水", 3, Common.DialogueType.BEDROOM_TERMINAL_APRANCE_BROKEN_USE_WATER)
	elif dialogue_type == Common.DialogueType.BEDROOM_TERMINAL_NORMAL_USE_SCREWDRIVER:
		Common.show_progress_bar("正在撬开控制终端", 5, Common.DialogueType.BEDROOM_TERMINAL_NORMAL_USE_SCREWDRIVER)
	pass


func on_recv_door_unstable(door_idx):
	if door_idx == Common.DoorIdx.BEDROOM:
		$FixedLight/Bedroom/TopTapeLight.set_color(Color(0.8,0.3,0.3))
		$FixedLight/Bedroom/ScreenLight.set_color(Color(0.8,0.3,0.3))
		$BedroomOut/Rays.show()
		pass
	pass

func coma():
	Common.input_lock = true
	var tween = create_tween().set_trans(Tween.TRANS_LINEAR)
	tween.tween_property($WorldEnvironment,"environment:adjustment_brightness",0.0,2)
	tween.play()
	await tween.finished
	get_tree().reload_current_scene()
	pass
