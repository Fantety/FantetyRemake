extends Node

signal call_change_door_status(idx,status)
signal call_shake_camera(duration)
signal call_reach_floor(floor)
signal call_elevator_arrived(floor)
signal call_show_player_emo(emo_type)
signal call_hide_player_emo()
signal call_change_player_area(area_type)
signal call_show_dialogue(area_type)
signal call_player_velocity(velocity)
signal call_player_collision_occured()
signal call_progress_finished(dialogue_type)
signal call_player_enter_area(area_name)
signal call_player_exit_area(area_name)
signal call_door_is_unstable(door_idx)
signal call_player_enter_ray()


signal bedroom_mini_game_goal()
signal bedroom_mini_game_finished()
