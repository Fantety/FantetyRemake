extends PointLight2D


func _on_area_2d_body_entered(body):
	if body.name == "Player" and Common.player_permission <= 0:
		CommonSignal.emit_signal("call_player_enter_ray")
		pass
	pass # Replace with function body.


func _on_area_2d_body_exited(body):
	if body.name == "Player" and Common.player_permission <= 0:
		pass
	pass # Replace with function body.
