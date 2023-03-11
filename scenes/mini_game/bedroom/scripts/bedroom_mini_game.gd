extends CanvasLayer


var target_rect = load("res://scenes/mini_game/bedroom/target_rect.tscn")
var score = 0
# Called when the node enters the scene tree for the first time.
func _ready():
	$Line1/AnimationPlayer.set_speed_scale(1)
	$Line2/AnimationPlayer.set_speed_scale(1)
	CommonSignal.bedroom_mini_game_goal.connect(Callable(self,"on_bedroom_mini_game_goal"))
	$Line1/AnimationPlayer.play("line1_show")
	$Line2/AnimationPlayer.play("line2_show")
	await $Line2/AnimationPlayer.animation_finished
	$Line1/AnimationPlayer.play("line1_run")
	$Line2/AnimationPlayer.play("line2_run")
	$Timer.start()
	$Timer2.start()
	$Line1/AnimationPlayer.set_speed_scale(0.6)
	$Line2/AnimationPlayer.set_speed_scale(0.6)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	$Control/Label.set_text(String.num(score))
	if score == 50:
		CommonSignal.emit_signal("bedroom_mini_game_finished")
		Common.input_lock = false
		queue_free()
	pass


func _on_timer_timeout():
	var target = target_rect.instantiate();
	target.set_position(Vector2(randi_range(20,380),randi_range(20,200)))
	add_child(target)
	pass # Replace with function body.


func _on_timer_2_timeout():
	var target = target_rect.instantiate();
	target.set_position(Vector2(randi_range(20,380),randi_range(20,200)))
	add_child(target)
	pass # Replace with function body.


func on_bedroom_mini_game_goal():
	score += 1
	pass
