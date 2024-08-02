extends Node2D

var position_1 = Vector2(global.tilesize * 1, global.tilesize * 8)
var wall_initial_position = Vector2(global.tilesize * 7, global.tilesize * 5)

@onready var wall = $Wall
@onready var key_item = $Key
@onready var key_box = $KeyBox
@onready var character_1 = $Character1
var characters = 1
var active_colors = ["rojo"]

var curr_key = ""
var curr_box = ""

var keys = {
	"Key" = false
}

var boxes = {
	"KeyBox" = false
}

var items = [key_item,key_box]
var inside_key = false
var has_key = false
var inside_keybox = false
var box_solved = false
var wall_up = false
var panel_up = false
var max_input = 20
var key_flags = true
var active_buttons = [0,1,2,3,4]
var flags_entered = 0

func _ready():
	global_audio.play_music_level("forest")

func find_key():
	for key in keys:
		if keys[key]:
			return key

func reset_visibility():
	key_item.visible = true
	key_box.visible = true

func all_boxes_solved():
	var boxes_solved = true
	for box in boxes:
		boxes_solved = boxes_solved and boxes[box]
	box_solved = boxes_solved
	
func _process(_delta):
	if box_solved and !wall_up:
		await global.wall_up(self)
		
@onready var hint = $Hint
func _on_exit_pressed():
	hint.visible = false
