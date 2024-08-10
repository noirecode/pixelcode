extends Control
@onready var MASTER_BUS_ID = AudioServer.get_bus_index("Master")
@onready var MUSIC_BUS_ID = AudioServer.get_bus_index("Music")
@onready var SFX_BUS_ID = AudioServer.get_bus_index("SFX")
@onready var master_slider = $UI/PanelBG/Panel/MarginContainer/GridContainer/MasterSlider
@onready var music_slider = $UI/PanelBG/Panel/MarginContainer/GridContainer/MusicSlider
@onready var sfx_slider = $UI/PanelBG/Panel/MarginContainer/GridContainer/SFXSlider
@onready var logo_anim = $logoAnim
@onready var tutorial = $LevelScrolls/VertBox/Tutorial
@onready var bucles = $LevelScrolls/VertBox/Bucles
@onready var funciones = $LevelScrolls/VertBox/Funciones
@onready var condicionales = $LevelScrolls/VertBox/Condicionales
var level_panels = []
var level_buttons = []
var level_scores = []

func get_level_buttons():
	for panel_obj in level_panels:
		for child in panel_obj.get_children():
			if str_to_var(child.name) in range(19):
				level_buttons.append(child)
func get_level_scores():
	for panel_obj in level_panels:
		for child in panel_obj.get_children():
			if child.name.contains("Level"):
				level_scores.append(child)
func _ready():
	global.load_game()
	level_panels = [tutorial, bucles, funciones, condicionales]
	get_level_buttons()
	get_level_scores()
	logo_anim.play("sway")
	AudioServer.set_bus_volume_db(MASTER_BUS_ID, global.data.volume_settings.music)
	AudioServer.set_bus_volume_db(MUSIC_BUS_ID, global.data.volume_settings.music)
	global_audio.play_music_level("main")
	connect_levels(level_buttons)
	master_slider.value = db_to_linear(global.data.volume_settings.master)
	music_slider.value = db_to_linear(global.data.volume_settings.music)
	sfx_slider.value = db_to_linear(global.data.volume_settings.sfx)
@onready var transition = $transition

func connect_levels(container):
	for level in container:
		if str_to_var(level.name) in range(global.data.unlocked_levels+1):
			level.disabled = false
			level.pressed.connect(self.change_level.bind(level.name))
			load_level_score(level.name)
		else:
			level.disabled = true
			load_level_score(level.name)

func load_level_score(level_number):
	var stars = 0
	var level_name = "Level"+str(level_number)
	for score in level_scores:
		if score.name == level_name:
			stars = global.data.level_solutions[level_name][2]
			match stars:
				1:
					score.get_node("1star").visible = true
					score.get_node("2star").visible = false
					score.get_node("3star").visible = false
					score.get_node("Panel").visible = true
				2:
					score.get_node("1star").visible = false
					score.get_node("2star").visible = true
					score.get_node("3star").visible = false
					score.get_node("Panel").visible = true
				3:
					score.get_node("1star").visible = false
					score.get_node("2star").visible = false
					score.get_node("3star").visible = true
					score.get_node("Panel").visible = true
				_:
					score.get_node("1star").visible = false
					score.get_node("2star").visible = false
					score.get_node("3star").visible = false
					score.get_node("Panel").visible = false

func change_level(level_name):
	transition.play("fade_out")
	await transition.animation_finished
	get_tree().change_scene_to_file("res://Scenes/level_" + level_name +  ".tscn")

@onready var panel_bg = $UI/PanelBG
@onready var panel = $UI/PanelBG/Panel
@onready var credits = $UI/PanelBG/Credits

func _on_settings_pressed():
	panel_bg.visible = true

func _on_panel_bg_gui_input(event):
	if event is InputEventScreenTouch and event.is_pressed():
		panel_bg.visible = false
		panel.visible = true
		credits.visible = false
func _on_credits_pressed():
	panel.visible = false
	credits.visible = true

func _on_master_slider_value_changed(value):
	AudioServer.set_bus_volume_db(MASTER_BUS_ID, global.data.volume_settings.master)
	AudioServer.set_bus_mute(MASTER_BUS_ID, value < 0.05)
	global.data.volume_settings.master = linear_to_db(value)
	global.save_game()


func _on_music_slider_value_changed(value):
	AudioServer.set_bus_volume_db(MUSIC_BUS_ID, global.data.volume_settings.music)
	AudioServer.set_bus_mute(MUSIC_BUS_ID, value < 0.05)
	global.data.volume_settings.music = linear_to_db(value)
	global.save_game()


func _on_sfx_slider_value_changed(value):
	AudioServer.set_bus_volume_db(SFX_BUS_ID, global.data.volume_settings.sfx)
	AudioServer.set_bus_mute(SFX_BUS_ID, value < 0.05)
	global.data.volume_settings.sfx = linear_to_db(value)
	global.save_game()


func _on_logo_anim_animation_finished(_anim_name):
	logo_anim.play("sway")
