extends Node2D


var tick = 0.0
var tick_count = 0.1
# Called when the node enters the scene tree for the first time.
func _ready():
	$Door.set_door_idx(Common.DoorIdx.BEDROOM)
	$Door/DoorCtrlIn.set_door_permission(Common.DoorPermission.BEDROOM_ADMIT)
	$Door/DoorCtrlOut.set_door_permission(Common.DoorPermission.BEDROOM_ADMIT)
	CommonSignal.call_player_enter_area.connect(Callable(self,"on_player_enter_area"))
	CommonSignal.call_player_exit_area.connect(Callable(self,"on_player_exit_area"))
	CommonSignal.call_progress_finished.connect(Callable(self,"on_progress_finished"))
	pass # Replace with function body.

func _process(delta):
	if tick > tick_count:
		tick = 0.0
		if CommonStatus.common_status["bedroom_terminal"] == CommonStatus.Status.INSIDE_BROKEN:
			var light_count = $Lights.get_child_count()
			var light = $Lights.get_child(randi_range(0,light_count-1))
			light.set_enabled(!light.is_enabled())
		pass
	else:
		tick += delta
	
	pass



func on_player_enter_area(area_name):
	if area_name == "BedroomBed":
		CommonSignal.emit_signal("call_show_player_emo",Common.EmoType.DEFAULT)
		CommonSignal.emit_signal("call_change_player_area",Common.Areas.BEDROOM_BED)
	elif area_name == "BedroomDesk":
		CommonSignal.emit_signal("call_show_player_emo",Common.EmoType.DEFAULT)
		CommonSignal.emit_signal("call_change_player_area",Common.Areas.BEDROOM_DESK)
	elif area_name == "BedroomTerminal":
		CommonSignal.emit_signal("call_show_player_emo",Common.EmoType.DEFAULT)
		CommonSignal.emit_signal("call_change_player_area",Common.Areas.BEDROOM_TERMINAL)
	elif area_name == "BedroomSofa":
		CommonSignal.emit_signal("call_show_player_emo",Common.EmoType.DEFAULT)
		CommonSignal.emit_signal("call_change_player_area",Common.Areas.BEDROOM_SOFA)
	pass

func on_player_exit_area(area_name):
	CommonSignal.emit_signal("call_hide_player_emo")
	CommonSignal.emit_signal("call_change_player_area",Common.Areas.NONE)
	pass

func on_progress_finished(dialogue_type):
	if dialogue_type == Common.DialogueType.BEDROOM_TERMINAL_NORMAL_USE_SCREWDRIVER:
		Common.use_item("螺丝刀",Callable(self,"use_screwdriver"))
		pass
	elif dialogue_type == Common.DialogueType.BEDROOM_TERMINAL_APRANCE_BROKEN_USE_WATER:
		Common.use_item("装着水的杯子",Callable(self,"use_water"))
		pass
	pass


func use_screwdriver():
	CommonStatus.common_status["bedroom_terminal"] = CommonStatus.Status.APRANCE_BROKEN
	Common.show_tips("提示", "终端被敲开了一条裂缝")
	pass
	
func use_water():
	CommonStatus.common_status["bedroom_terminal"] = CommonStatus.Status.INSIDE_BROKEN
	$Door.is_stable = false
	
