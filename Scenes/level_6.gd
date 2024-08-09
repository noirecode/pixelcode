extends Control

var position_1 = Vector2(global.tilesize * 0, global.tilesize * 0)
var wall_initial_position = Vector2(global.tilesize * 6, global.tilesize * 7)

@onready var character_1 = $Control/Character1
@onready var wall = $Control/Wall
@onready var key_1 = $Control/Key1
@onready var key_2 = $Control/Key2
@onready var key_3 = $Control/Key3
@onready var key_box_1 = $Control/KeyBox1
@onready var key_box_2 = $Control/KeyBox2
@onready var key_box_3 = $Control/KeyBox3
var characters = 1
var active_colors = ["rojo"]

var curr_key = ""
var curr_box = ""

var keys = {
	"Key1" : false,
	"Key2" : false,
	"Key3" : false
}

var boxes = {
	"KeyBox1" : false,
	"KeyBox2" : false,
	"KeyBox3" : false
}

var panel_up = false
var max_input = 20
var active_buttons = [0,1,2,3,4,5]
var flags_entered = 0

var multiple_keys = true 


var inside_key = false
var inside_keybox = false
var box_solved = false
var wall_up = false
var key_flags = true

func find_key():
	for key in keys:
		if keys[key]:
			return key

func reset_visibility():
	key_1.visible = true
	key_box_1.visible = true
	key_2.visible = true
	key_box_2.visible = true
	key_3.visible = true
	key_box_3.visible = true

func all_boxes_solved():
	var boxes_solved = true
	for box in boxes:
		boxes_solved = boxes_solved and boxes[box]
	box_solved = boxes_solved
func _ready():
	global_audio.play_music_level("forest")

func _process(delta):
	if box_solved and !wall_up:
		await global.wall_up(self)
