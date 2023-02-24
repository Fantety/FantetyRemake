extends PointLight2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		CommonSignal.emit_signal("call_player_enter_ray")
		pass
	pass # Replace with function body.


func _on_area_2d_body_exited(body):
	if body.name == "Player":
		pass
	pass # Replace with function body.
