extends Area2D

func _on_body_entered(body):
	var current_scene = get_tree().current_scene.name
	if (body.name == "Character1"):
		
		get_parent().panel_up = true
		if global.data.level_solutions[current_scene][3] == false:
			global.data.level_solutions[current_scene][3] = true
			global.data.unlocked_levels += 1
		global.save_game()
		

