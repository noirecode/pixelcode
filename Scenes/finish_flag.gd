extends Area2D
@onready var sfx_level_complete = $level_complete

func _on_body_entered(body):
	if (body.name.contains("Character")):
		check_multiple()
		prints("flags_entered: ",get_parent().get_parent().flags_entered)

func finish_level():
	var current_scene = get_tree().current_scene.name
	sfx_level_complete.play()
	get_parent().get_parent().panel_up = true
	if global.data.level_solutions[current_scene][3] == false:
		global.data.level_solutions[current_scene][3] = true
		global.data.unlocked_levels += 1
	global.save_game()

func check_multiple():
	if get_parent().get_parent().characters == 1:
		finish_level()
	elif get_parent().get_parent().flags_entered != (get_parent().get_parent().characters):
		get_parent().get_parent().flags_entered += 1
		check_flags()
		
func check_flags():
	if get_parent().get_parent().flags_entered == get_parent().get_parent().characters:
		finish_level()


func _on_body_exited(body):
	if (body.name.contains("Character")):
		if get_parent().get_parent().characters > 1 and get_parent().get_parent().flags_entered>0:
			get_parent().flags_entered -= 1
	
	prints("flags_entered: ",get_parent().get_parent().flags_entered)
