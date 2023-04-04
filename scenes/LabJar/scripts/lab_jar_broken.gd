extends Sprite2D

func _on_area_2d_body_entered(body):
	if body.name == "Player":
		CommonSignal.emit_signal("call_show_player_emo", Common.EmoType.DEFAULT)
		CommonSignal.emit_signal("call_change_player_area",Common.Areas.LAB_JAR_BROKEN)
		Common.current_lab_jar_num = 5
	pass # Replace with function body.


func _on_area_2d_body_exited(body):
	if body.name == "Player":
		CommonSignal.emit_signal("call_hide_player_emo")
		CommonSignal.emit_signal("call_change_player_area",Common.Areas.NONE)
		Common.current_lab_jar_num = 0
	pass # Replace with function body.
