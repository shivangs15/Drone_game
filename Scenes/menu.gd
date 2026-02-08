extends Control


func _process(_delta: float) -> void:
	if Input.is_action_just_pressed("Restart"):
		get_tree().change_scene_to_file("res://Scenes/Levels/level.tscn")
