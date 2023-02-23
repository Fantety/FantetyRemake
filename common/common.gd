extends Node

enum  DoorIdx{
	BEDROOM = 1,
	ELEVATOR_FOURTH_RIGHT = 2,
	ELEVATOR_FOURTH_LEFT,
	ELEVATOR_THRID_RIGHT,
	ELEVATOR_THRID_LEFT,
	ELEVATOR_SECOND_RIGHT,
	ELEVATOR_SECOND_LEFT,
	ELEVATOR_FIRST_RIGHT,
	ELEVATOR_FIRST_LEFT,
}
enum EmoType{
	DEFAULT = 0,
	AMAZED = 1,
	QUERY = 2,
}

enum Areas{
	NONE = 0,
	BEDROOM_BED = 1,
	BEDROOM_DESK,
	BEDROOM_TERMINAL,
	BEDROOM_SOFA,
}

enum  DoorPermission{
	NONE = -1,
	BEDROOM_ADMIT = 999,
	ELEVATOR_ADMIT = 1,
}

enum  DialogueType{
	BEDROOM_BED_FIRST = 1,
	BEDROOM_DESK_FIRST,
	BEDROOM_TERMINAL_FIRST,
	BEDROOM_SOFA_FIRST,
	BEDROOM_TERMINAL_NORMAL_USE_WATER,
	BEDROOM_TERMINAL_APRANCE_BROKEN_USE_WATER,
	BEDROOM_TERMINAL_NORMAL_USE_SCREWDRIVER,
}

var elevator_current_floor = 4
var input_lock = false
var player_permission = 0


func show_tips(title,content):
	get_tree().paused = true
	var tip_bar = load("res://scenes/tips/tips.tscn").instantiate()
	tip_bar.show_tips(title,content)
	add_child(tip_bar)

func show_progress_bar(title,duration):
	var progress_bar = load("res://scenes/progress_bar/progress_bar.tscn").instantiate()
	progress_bar.start_progress(title,duration)
	add_child(progress_bar)
