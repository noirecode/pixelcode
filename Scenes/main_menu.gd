extends Control
@onready var MASTER_BUS_ID = AudioServer.get_bus_index("Master")
@onready var MUSIC_BUS_ID = AudioServer.get_bus_index("Music")
@onready var SFX_BUS_ID = AudioServer.get_bus_index("SFX")

func _ready():
	global.load_game()
	AudioServer.set_bus_volume_db(MASTER_BUS_ID, global.data.volume_settings.music)
	AudioServer.set_bus_volume_db(MUSIC_BUS_ID, global.data.volume_settings.music)
	global_audio.play_music_level("main")
	for i in range($ScrollContainer/VScrollBar/MenuMap/Levels.get_child_count()):
		global.levels.append(i+1)
	
	for level in $ScrollContainer/VScrollBar/MenuMap/Levels.get_children():
		if str_to_var(level.name) in range(global.data.unlocked_levels+1):
			level.disabled = false
			level.pressed.connect(self.change_level.bind(level.name))
		else:
			level.disabled = true

func change_level(level_name):
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
	global.data.volume_settings.master = linear_to_db(value)
	AudioServer.set_bus_volume_db(MASTER_BUS_ID, global.data.volume_settings.master)
	AudioServer.set_bus_mute(MASTER_BUS_ID, value < 0.05)
	global.save_game()


func _on_music_slider_value_changed(value):
	global.data.volume_settings.music = linear_to_db(value)
	AudioServer.set_bus_volume_db(MUSIC_BUS_ID, global.data.volume_settings.music)
	AudioServer.set_bus_mute(MUSIC_BUS_ID, value < 0.05)
	global.save_game()


func _on_sfx_slider_value_changed(value):
	pass # Replace with function body.
