extends Node2D

var position_1 = Vector2(global.tilesize * 0, global.tilesize * 9)

@onready var character_1 = $Character1
var characters = 1
var active_colors = ["rojo"]


var panel_up = false
var max_input = 20
var active_buttons = [0,1,2,5,6,7]

func _ready():
	global_audio.play_music_level("farm")
