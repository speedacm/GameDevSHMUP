extends Control


func _on_StartGame_pressed():
	get_tree().change_scene_to_file("res://Scenes/Test_Main.tscn")
	pass 


func _on_QuitGame_pressed():
	get_tree().quit()
	pass
