extends Node

var dialogue_data = "res://assets/data/dialogue_data.json"
var dialogue_dic:Dictionary



func _ready():
	var file = FileAccess.open(dialogue_data, FileAccess.READ)
	if file == null:
		pass
	else:
		var json_str = file.get_as_text()
		dialogue_dic = JSON.parse_string(json_str)
