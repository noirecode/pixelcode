extends Control
@onready var retry = $Panel/RETRY
@onready var home = $Panel/HOME
@onready var next = $Panel/NEXT

var levels = {
	"Level1": {"next_scene": "res://Scenes/level_2.tscn"},
	"Level2": {"next_scene": "res://Scenes/level_3.tscn"},
	"Level3": {"next_scene": "res://Scenes/level_4.tscn"},
	"Level4": {"next_scene": "res://Scenes/level_5.tscn"},
	"Level5": {"next_scene": "res://Scenes/level_6.tscn"},
	"Level6": {"next_scene": "res://Scenes/level_7.tscn"},
	"Level7": {"next_scene": "res://Scenes/level_8.tscn"},
	"Level8": {"next_scene": "res://Scenes/level_9.tscn"},
	"Level9": {"next_scene": "res://Scenes/level_10.tscn"},
	"Level10": {"next_scene": "res://Scenes/level_11.tscn"},
	"Level11": {"next_scene": "res://Scenes/level_12.tscn"},
	"Level12": {"next_scene": "res://Scenes/level_13.tscn"},
	"Level13": {"next_scene": "res://Scenes/main_menu.tscn"},
	"Level14": {"next_scene": "res://Scenes/main_menu.tscn"},
	"Level15": {"next_scene": "res://Scenes/main_menu.tscn"},
	"Level16": {"next_scene": "res://Scenes/main_menu.tscn"},
	"Level17": {"next_scene": "res://Scenes/main_menu.tscn"},
	"Level18": {"next_scene": "res://Scenes/main_menu.tscn"}
}

var score_num = 1
var current_scene 
@onready var star1 = $"Panel/1star"
@onready var star2 = $"Panel/2stars"
@onready var star3 = $"Panel/3stars"

func _process(_delta):
	if self.visible:
		score_num = global.calculate_score(current_scene)
		match score_num:
			1:
				star1.visible = true
				star2.visible = false
				star3.visible = false
			2:
				star1.visible = false
				star2.visible = true
				star3.visible = false
			3:
				star1.visible = false
				star2.visible = false
				star3.visible = true

func _ready():
	current_scene = get_tree().current_scene.name

func _on_retry_pressed():
	get_tree().reload_current_scene()

func _on_home_pressed():
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

func _on_next_pressed():
	current_scene = get_tree().current_scene.name
	if current_scene in levels:
		get_tree().change_scene_to_file(levels[current_scene].next_scene)
