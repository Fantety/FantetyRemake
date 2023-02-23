extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Door.set_door_idx(Common.DoorIdx.BEDROOM)
	$Door/DoorCtrlIn.set_door_permission(Common.DoorPermission.BEDROOM_ADMIT)
	$Door/DoorCtrlOut.set_door_permission(Common.DoorPermission.BEDROOM_ADMIT)
	CommonSignal.call_player_enter_area.connect(Callable(self,"on_player_enter_area"))
	CommonSignal.call_player_exit_area.connect(Callable(self,"on_player_exit_area"))
	pass # Replace with function body.


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
	pass

func on_player_exit_area(area_name):
	CommonSignal.emit_signal("call_hide_player_emo")
	CommonSignal.emit_signal("call_change_player_area",Common.Areas.NONE)
	pass
