extends Camera2D


# Called when the node enters the scene tree for the first time.
func _ready():
	CommonSignal.call_shake_camera.connect(Callable(self,"shake_camera"))
	pass # Replace with function body.


func shake_camera(duration):
	$Shaker.set_duration(duration)
	$Shaker.start()
	pass
