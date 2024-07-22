extends Node2D

var initial_position = Vector2(global.tilesize * 7, global.tilesize * 9)

@onready var character_1 = $Character1


var panel_up = false
var max_input = 30
var active_buttons = [0,1,2,6,7]

func _ready():
	global_audio.play_music_level("farm")

