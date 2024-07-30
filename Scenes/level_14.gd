extends Node2D
@onready var character_1 = $Character1
@onready var character_2 = $Character2
var characters = 2
var position_1 = Vector2(global.tilesize * 0, global.tilesize * 8)
var position_2 = Vector2(global.tilesize * 0, global.tilesize * 4)
var panel_up = false
var max_input = 20
var active_buttons = [0,1,2,5,6,7]
var active_colors = ["rojo","verde"]
func _ready():
	global_audio.play_music_level("farm")
