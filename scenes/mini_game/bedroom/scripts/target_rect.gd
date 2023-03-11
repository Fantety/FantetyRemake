extends ColorRect


var can_disdory = false

func _ready():
	var tween = create_tween().set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(self,"scale",Vector2(1,1),0.5)
	tween.play()
	await tween.finished
	pass

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("ui_accept") and can_disdory == true:
		CommonSignal.emit_signal("bedroom_mini_game_goal")
		$CPUParticles2D.set_emitting(true)
		var tween1 = create_tween().set_trans(Tween.TRANS_LINEAR)
		tween1.tween_property(self,"scale",Vector2(0,0),0.2)
		tween1.play()
		$AudioStreamPlayer.play()
		$Timer2.start()
	pass


func _on_area_2d_area_entered(area):
	if area.name == "Line1Area2D" or area.name == "Line2Area2D":
		can_disdory = true
		set_color(Color("#2bc2d2"))
	pass # Replace with function body.


func _on_area_2d_area_exited(area):
	if area.name == "Line1Area2D" or area.name == "Line2Area2D":
		can_disdory = false
		set_color(Color("#ffffff"))
	pass # Replace with function body.


func _on_timer_timeout():
	var tween = create_tween().set_trans(Tween.TRANS_LINEAR)
	tween.tween_property(self,"scale",Vector2(0,0),0.5)
	tween.play()
	await tween.finished
	queue_free()
	pass # Replace with function body.


func _on_timer_2_timeout():
	queue_free()
	pass # Replace with function body.
