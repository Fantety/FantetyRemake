extends CanvasLayer

func _process(_delta):
	if Input.is_action_just_pressed("exit_tips") and is_visible():
		get_tree().paused = false
		queue_free()
	pass


func show_tips(title,content):
	$PanelContainer/MarginContainer/VBoxContainer/Title.set_text(title)
	$PanelContainer/MarginContainer/VBoxContainer/Content.set_text(content)
	pass
