extends CanvasLayer

func _ready():
	CommonSignal.call_player_velocity.connect(Callable(self,"on_recv_player_velocity"))
	pass


func start_progress(title, duration, dialogue_type):
	$PanelContainer/MarginContainer/VBoxContainer/Label.set_text(title)
	var tween1  = create_tween().set_trans(Tween.TRANS_CUBIC)
	tween1.tween_property($PanelContainer,"position:y",0,1)
	tween1.play()
	await tween1.finished
	var tween2 = get_tree().create_tween().set_trans(Tween.TRANS_LINEAR)
	tween2.tween_property($PanelContainer/MarginContainer/VBoxContainer/ProgressBar,"value",100,duration)
	tween2.play()
	await tween2.finished
	CommonSignal.emit_signal("call_progress_finished",dialogue_type)
	queue_free()

func on_recv_player_velocity(velocity):
	if velocity.x > 0.0 or velocity.y > 0.0:
		CommonSignal.call_player_velocity.disconnect(Callable(self,"on_recv_player_velocity"))
		var tween  = get_tree().create_tween().set_trans(Tween.TRANS_CUBIC)
		tween.tween_property($PanelContainer,"position:y",-100,1)
		tween.play()
		await tween.finished
		queue_free()
	pass
