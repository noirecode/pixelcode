extends Control

var position_1 = Vector2(global.tilesize * 7, global.tilesize * 9)

@onready var character_1 = $Control/Character1
var characters = 1
var active_colors = ["rojo"]


var panel_up = false
var max_input = 30
var active_buttons = [0,1,2,6,7]
var flags_entered = 0

func _ready():
	global_audio.play_music_level("farm")

