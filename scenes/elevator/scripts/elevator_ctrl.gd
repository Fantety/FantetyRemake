extends CanvasLayer

func _on_button_1_pressed():
	if Common.elevator_current_floor != 1:
		CommonSignal.emit_signal("call_reach_floor",1)
	queue_free()
	pass # Replace with function body.


func _on_button_2_pressed():
	if Common.elevator_current_floor != 2:
		CommonSignal.emit_signal("call_reach_floor",2)
	queue_free()
	pass # Replace with function body.


func _on_button_3_pressed():
	if Common.elevator_current_floor != 3:
		CommonSignal.emit_signal("call_reach_floor",3)
	queue_free()
	pass # Replace with function body.


func _on_button_4_pressed():
	if Common.elevator_current_floor != 4:
		CommonSignal.emit_signal("call_reach_floor",4)
	queue_free()
	pass # Replace with function body.
