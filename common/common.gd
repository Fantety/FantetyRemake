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
	BEDROOM_DESK_FIRST = 2,
	BEDROOM_TERMINAL_FIRST = 3,
	BEDROOM_SOFA_FIRST = 4,
	BEDROOM_TERMINAL_NORMAL_USE_WATER = 5,
	BEDROOM_TERMINAL_APRANCE_BROKEN_USE_WATER = 6,
	BEDROOM_TERMINAL_NORMAL_USE_SCREWDRIVER = 7,
}

var elevator_current_floor = 4
var input_lock = false
var player_permission = 0


func show_tips(title,content):
	get_tree().paused = true
	var tip_bar = load("res://scenes/tips/tips.tscn").instantiate()
	add_child(tip_bar)
	tip_bar.show_tips(title,content)
	
func show_progress_bar(title,duration,dialogue_type):
	var progress_bar = load("res://scenes/progress_bar/progress_bar.tscn").instantiate()
	add_child(progress_bar)
	progress_bar.start_progress(title,duration,dialogue_type)
	
func acquire_item(item_name):
	CommonBackpack.backpack[item_name] += 1
	CommonBackpack.item_acquisition_record[item_name] = true
	pass

func use_item(item_name, used_action:Callable):
	if CommonBackpack.backpack[item_name] <= 0:
		Common.show_tips("警告", "你的背包中没有此物品")
	else:
		CommonBackpack.backpack[item_name] -= 1
		used_action.call()
	pass
