extends AnimatedSprite2D


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_area_2d_body_entered(body):
	if body.name == "Player":
		CommonSignal.emit_signal("call_show_player_emo", Common.EmoType.DEFAULT)
		if self.name == "LabJar1":
			CommonSignal.emit_signal("call_change_player_area",Common.Areas.LAB_JAR1)
			Common.current_lab_jar_num = 1
		elif self.name == "LabJar2":
			CommonSignal.emit_signal("call_change_player_area",Common.Areas.LAB_JAR2)
			Common.current_lab_jar_num = 2
		elif self.name == "LabJar3":
			CommonSignal.emit_signal("call_change_player_area",Common.Areas.LAB_JAR3)
			Common.current_lab_jar_num = 3
		elif self.name == "LabJar4":
			CommonSignal.emit_signal("call_change_player_area",Common.Areas.LAB_JAR4)
			Common.current_lab_jar_num = 4
		elif self.name == "LabJar6":
			CommonSignal.emit_signal("call_change_player_area",Common.Areas.LAB_JAR6)
			Common.current_lab_jar_num = 6
		elif self.name == "LabJar7":
			CommonSignal.emit_signal("call_change_player_area",Common.Areas.LAB_JAR7)
			Common.current_lab_jar_num = 7
		elif self.name == "LabJar8":
			CommonSignal.emit_signal("call_change_player_area",Common.Areas.LAB_JAR8)
			Common.current_lab_jar_num = 8
		elif self.name == "LabJar9":
			CommonSignal.emit_signal("call_change_player_area",Common.Areas.LAB_JAR9)
			Common.current_lab_jar_num = 9
		elif self.name == "LabJar10":
			CommonSignal.emit_signal("call_change_player_area",Common.Areas.LAB_JAR10)
			Common.current_lab_jar_num = 10
		elif self.name == "LabJar11":
			CommonSignal.emit_signal("call_change_player_area",Common.Areas.LAB_JAR11)
			Common.current_lab_jar_num = 11
	pass # Replace with function body.


func _on_area_2d_body_exited(body):
	if body.name == "Player":
		CommonSignal.emit_signal("call_hide_player_emo")
		CommonSignal.emit_signal("call_change_player_area",Common.Areas.NONE)
		Common.current_lab_jar_num = 0
	pass # Replace with function body.
