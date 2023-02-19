extends Node2D


# Called when the node enters the scene tree for the first time.
func _ready():
	$Door.set_door_idx(Common.DoorIdx.BEDROOM)
	pass # Replace with function body.



func _on_bed_body_entered(body):
	if body.name == "Player":
		CommonSignal.emit_signal("call_show_player_emo",Common.EmoType.DEFAULT)
		CommonSignal.emit_signal("call_change_player_area",Common.Areas.BEDROOM_BED)
	pass # Replace with function body.


func _on_bed_body_exited(body):
	if body.name == "Player":
		CommonSignal.emit_signal("call_hide_player_emo")
		CommonSignal.emit_signal("call_change_player_area",Common.Areas.NONE)
	pass # Replace with function body.
