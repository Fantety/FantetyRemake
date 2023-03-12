extends Node2D

var tick = 0.0
var tick_count = 0.01

# Called when the node enters the scene tree for the first time.
func _ready():
	$Player/Vertigo.hide()
	var tween = create_tween().set_trans(Tween.TRANS_LINEAR)
	tween.tween_property($WorldEnvironment,"environment:adjustment_brightness",1.0,2)
	tween.play()
	await tween.finished
	Common.input_lock = false
	CommonSignal.call_elevator_arrived.connect(Callable(self,"elevator_arrived_open_door"))
	CommonSignal.call_show_dialogue.connect(Callable(self,"show_area_dialogue"))
	CommonSignal.call_door_is_unstable.connect(Callable(self,"on_recv_door_unstable"))
	CommonSignal.call_player_enter_ray.connect(Callable(self,"coma"))
	CommonSignal.bedroom_mini_game_finished.connect(Callable(self,"on_bedroom_mini_game_finished"))
	CommonSignal.call_start_elevator_plot.connect(Callable(self,"on_call_start_elevator_plot"))
	CommonSignal.call_elevator_fallen.connect(Callable(self,"on_call_elevator_fallen"))
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
	elif dialogue_type == Common.DialogueType.BEDROOM_TERMINAL_DIFFERENT:
		Common.input_lock = true
		var bedroom_mini_game = load("res://scenes/mini_game/bedroom/bedroom_mini_game.tscn").instantiate()
		add_child(bedroom_mini_game)
	pass


func on_recv_door_unstable(door_idx):
	if door_idx == Common.DoorIdx.BEDROOM:
		$FixedLight/TopTapeLight.set_color(Color(0.8,0.3,0.3))
		$FixedLight/ScreenLight.set_color(Color(0.8,0.3,0.3))
		$BedroomOut/Rays.show()
		pass
	pass

func set_all_fixedlight_color(color):
	for i in $FixedLight.get_children():
		i.set_color(Color(0.8,0.3,0.3))
	pass

func _process(delta):
	if CommonStatus.lab_status == CommonStatus.LabStatus.SERIOUS:
		if !$AlarmSerious.is_playing():
			$AlarmSerious.play()
		if tick > tick_count:
			set_all_fixedlight_color(Color(0.8,0.3,0.3))
			tick += delta
			if tick > 2*tick_count:
				tick = 0.0
		else:
			tick += delta
			set_all_fixedlight_color(Color(1,1,1))
	pass


func coma():
	CommonStatus.lab_status = CommonStatus.LabStatus.SERIOUS
	for i in range(1,9):
		CommonSignal.emit_signal("call_change_door_status",i,false)
	pass

func on_bedroom_mini_game_finished():
	CommonStatus.lab_status = CommonStatus.LabStatus.NORMAL
	$AlarmSerious.stop()
	set_all_fixedlight_color(Color(1,1,1))
	var dialogue_species = CommonDialogue.dialogue_dic["5"]
	Common.player_permission = 1
	Common.show_tips(dialogue_species[0],dialogue_species[1])
	pass

func on_call_start_elevator_plot():
	var tween = create_tween().set_trans(Tween.TRANS_LINEAR)
	tween.tween_property($WorldEnvironment.environment,"adjustment_saturation",0.01,1)
	tween.play()
	CommonSignal.emit_signal("call_reach_floor",1)
	var tween1 = create_tween().set_trans(Tween.TRANS_QUAD)
	tween1.tween_property($WorldEnvironment.environment,"adjustment_brightness",0.01,3.0)
	tween1.play()
	pass
	

func on_call_elevator_fallen():
	var tween1 = create_tween().set_trans(Tween.TRANS_LINEAR)
	tween1.tween_property($WorldEnvironment.environment,"adjustment_brightness",1.0,1)
	tween1.play()
	var tween = create_tween().set_trans(Tween.TRANS_LINEAR)
	tween.tween_property($WorldEnvironment.environment,"adjustment_saturation",1.0,1)
	tween.play()
	$Player/Vertigo.show()
	CommonSignal.emit_signal("call_set_player_speed_limit",51)
	CommonSignal.emit_signal("call_player_tinnitus")
	CommonSignal.emit_signal("call_change_door_status",Common.DoorIdx.ELEVATOR_FIRST_LEFT,true)
	CommonSignal.emit_signal("call_change_door_status",Common.DoorIdx.ELEVATOR_FIRST_RIGHT,true)
	CommonSignal.emit_signal("call_change_elevator_monitoring_status",false)
	CommonStatus.elevator_plot_status = true
	var tween2 = create_tween().set_trans(Tween.TRANS_LINEAR)
	tween2.tween_property($Player/Vertigo.material,"shader_parameter/alpha",0.0,12.5)
	tween2.play()
	await tween2.finished
	$Player/Vertigo.hide()
	pass
