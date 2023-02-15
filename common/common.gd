extends Node

enum  DoorIdx{
	BEDROOM = 1,
	ELEVATOR_FOURTH_RIGHT = 2,
}
enum EmoType{
	DEFAULT = 0,
	AMAZED = 1,
	QUERY = 2,
}
var elevator_current_floor = 4

var input_lock = false
