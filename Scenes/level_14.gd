extends Node2D


#
var panel_up = false
var max_input = 20
var active_buttons = [0,1,2,5,6,7]

func _ready():
	global_audio.play_music_level("farm")
