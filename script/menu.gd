extends Control

func _on_play_pressed() -> void:
	print("Start Pressed")
	get_tree().change_scene_to_file("res://Assets/scene/area/level_1.tscn")
	

func _on_options_pressed() -> void:
	print("options Pressed")
	get_tree().change_scene_to_file("res://Assets/scene/options_menu.tscn")


func _on_exit_pressed() -> void:
	print("Exit Pressed")
	get_tree().quit()

func _on_pressed() -> void:
	get_tree().change_scene_to_file("res://Assets/scene/options_menu.tscn")
