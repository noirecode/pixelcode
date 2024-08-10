extends Area2D
@onready var sfx_level_complete = $level_complete
var level_scene = ''

func _ready():
	level_scene = get_parent().get_parent()
func _on_body_entered(body):
	if (body.name.contains("Character")):
		check_multiple()
		prints("flags_entered: ",level_scene.flags_entered)

func finish_level():
	var current_scene = get_tree().current_scene.name
	sfx_level_complete.play()
	level_scene.panel_up = true
	if global.data.level_solutions[current_scene][3] == false:
		global.data.level_solutions[current_scene][3] = true
		global.data.unlocked_levels += 1
	global.save_game()

func check_multiple():
	if level_scene.characters == 1:
		finish_level()
	elif level_scene.flags_entered != (level_scene.characters):
		level_scene.flags_entered += 1
		check_flags()
		
func check_flags():
	if level_scene.flags_entered == level_scene.characters:
		finish_level()


func _on_body_exited(body):
	if (body.name.contains("Character")):
		if level_scene.characters > 1 and level_scene.flags_entered>0:
			level_scene.flags_entered -= 1
	
	prints("flags_entered: ",level_scene.flags_entered)
