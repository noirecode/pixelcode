extends Node2D
## hints
@onready var pages = $Hint/Panel/pages
@onready var exit = $Hint/Panel/exit
@onready var hint = $Hint


var total_pages = 3
var curr_page = 1

func page_flip(number):
	match number:
		1:
			if curr_page >= total_pages:
				return
		-1:
			if curr_page <= 1:
				return
	var page_name = "page" + str(curr_page)
	var page_node = page_handler(page_name)
	page_node.visible = false
	curr_page = curr_page + number
	page_name = "page" + str(curr_page)
	page_node = page_handler(page_name)
	page_node.visible = true
	
func page_handler(page_name):
	for page in pages.get_children():
		if page.name == page_name:
			return page

func reset_hint():
	curr_page = 1
	var page_name = "page" + str(curr_page)
	for page in pages.get_children():
		if page.name == page_name:
			page.visible = true
		else:
			page.visible = false
	prev.visible = false
	next.visible = true
	exit.visible = false

func _on_next_pressed():
	page_flip(1)
	validate_buttons()

func _on_prev_pressed():
	page_flip(-1)
	validate_buttons()

func validate_buttons():
	match curr_page:
		1:
			prev.visible = false
			exit.visible = false
		total_pages:
			next.visible = false
			exit.visible = true
		_:
			next.visible = true
			prev.visible = true
			exit.visible = false
			

func _on_exit_pressed():
	hint.visible = false

#####
var initial_position = Vector2(global.tilesize * 2, global.tilesize * 7)
var flag_initial_position = Vector2(global.tilesize * 6, global.tilesize * 6)
var max_input = 10
var active_buttons = [0,1]
var panel_up = false
@onready var character_1 = $Character1
@onready var prev = $Hint/Panel/prev
@onready var next = $Hint/Panel/next

func _ready():
	global_audio.play_music_level("forest")


