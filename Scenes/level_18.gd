extends Node2D
@onready var character_1 = $Character1
@onready var character_2 = $Character2
@onready var character_3 = $Character3

var characters = 3
var position_1 = Vector2(global.tilesize * 9, global.tilesize * 2)
var position_2 = Vector2(global.tilesize * 4, global.tilesize * 9)
var position_3 = Vector2(global.tilesize * 0, global.tilesize * 4)
var panel_up = false
var max_input = 25
var active_buttons = [0,1,2,5,8]
var active_colors = ["rojo","verde","azul"]
var flags_entered = 0
func _ready():
	global_audio.play_music_level("farm")
