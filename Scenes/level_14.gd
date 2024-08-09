extends Control
@onready var character_1 = $Control/Character1
@onready var character_2 = $Control/Character2
var characters = 2
var position_1 = Vector2(global.tilesize * 0, global.tilesize * 8)
var position_2 = Vector2(global.tilesize * 0, global.tilesize * 4)
var panel_up = false
var max_input = 20
var active_buttons = [0,1,2,5,8]
var active_colors = ["rojo","verde"]
var flags_entered = 0
func _ready():
	global_audio.play_music_level("farm")
