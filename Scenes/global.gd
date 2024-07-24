extends Node
var levels = []
var data = {
	"volume_settings": {
		"master" = 1,
		"music" = 1,
		"sfx" = 1
	},
	"unlocked_levels": 1,
	"level_solutions": {
		#[number of lines in solution], [lines for 3 stars, 2 stars, 1 star], stars, unlocked stat
		"Level1" = [0, [5,6,10],0, false], 
		"Level2" = [0, [5,6,10],0, false],
		"Level3" = [0, [12,15,20],0, false],
		"Level4" = [0, [5,5,10],0, false],
		"Level5" = [0, [8,13,17],0, false],
		"Level6" = [0, [12,15,20],0, false],
		"Level7" = [0, [9,9,11],0, false],
		"Level8" = [0, [11,13,15],0, false],
		"Level9" = [0, [8,9,13],0, false],
		"Level10" = [0, [21,23,25],0, false],
		"Level11" = [0, [20,20,23],0, false],
		"Level12" = [0, [14,15,17],0, false],
		"Level13" = [0, [12,15,17],0, false],
		
		"Level14" = [0, [11,15,20],1, false],
		"Level15" = [0, [11,15,20],1, false],
		"Level16" = [0, [11,15,20],1, false],
		"Level17" = [0, [11,15,20],1, false],
		"Level18" = [0, [11,15,20],1, false],
	}
}
var path = "user://save.json"
const TILE_SIZE = Vector2(72,72)
const tilesize = 18*4
func save_game():
	var file = FileAccess.open(path, FileAccess.WRITE)
	if file:
		file.store_string(JSON.stringify(data))
		file.close()
	else:
		print("Could not save data.")

func load_game():
	var file = FileAccess.open(path, FileAccess.READ)
	if file:
		global.data = str_to_var(file.get_as_text())
		file.close()
	else:
		print("No save file found.")


func wall_up(level):
	var tween = get_tree().create_tween()
	var target_position = level.wall_initial_position + (Vector2.UP * 2) * TILE_SIZE
	tween.tween_property(level.wall, "position", target_position, 0.35)
	await tween.finished
	level.wall.position = target_position
	level.wall_up = true

func reset_level(level, key_flags):
	if key_flags:
		for key in level.keys:
			level.keys[key] = false
		for box in level.boxes:
			level.boxes[box] = false
		level.reset_visibility()
		level.wall_up  = false
		level.wall.position = level.wall_initial_position
		level.inside_key = false
		level.inside_keybox = false
		level.box_solved = false
	level.character_1.flip(false)
	level.character_1.position = level.initial_position

func calculate_score(level_name):
	if data.level_solutions[level_name][0] <= data.level_solutions[level_name][1][0]:
		if data.level_solutions[level_name][2] < 3:
			data.level_solutions[level_name][2] = 3
		return 3
	elif data.level_solutions[level_name][0] == data.level_solutions[level_name][1][1]:
		if data.level_solutions[level_name][2] < 2:
			data.level_solutions[level_name][2] = 2
		return 2
	else:
		if data.level_solutions[level_name][2] <=1:
			data.level_solutions[level_name][2] = 1
		return 1
