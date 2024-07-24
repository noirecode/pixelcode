extends Control
var instructions_list = []
var running = false
var current_scene

@onready var character_1 = $"../Character1"
@onready var console_text = $Console/ConsoleBG/ConsoleText
@onready var popup_panel = $Console/ScrollContainer/Commands/PopupPanel

@onready var finish_panel = $Finish_Panel

@onready var master_slider = $Volume/Panel/MarginContainer/VBoxContainer/GridContainer/MasterSlider
@onready var music_slider = $Volume/Panel/MarginContainer/VBoxContainer/GridContainer/MusicSlider
@onready var sfx_slider = $Volume/Panel/MarginContainer/VBoxContainer/GridContainer/SFXSlider
@onready var sfx_button = $sfx_button

@onready var text_edit = $Console/ConsoleBG/TextEdit

@onready var run_button = $Console/Edit/run
@onready var delete_button = $Console/Edit/delete
@onready var restart_button = $Console/Edit/restart

@onready var mover_der_button = $"Console/ScrollContainer/Commands/moverDer()"
@onready var mover_izq_button = $"Console/ScrollContainer/Commands/moverIzq()"
@onready var saltar_button = $"Console/ScrollContainer/Commands/saltar()"
@onready var tomar_llave_button = $"Console/ScrollContainer/Commands/tomarLlave()"
@onready var utilizar_llave_button = $"Console/ScrollContainer/Commands/utilizarLlave()"
@onready var saltar_arriba_button = $"Console/ScrollContainer/Commands/PopupPanel/HBoxContainer/saltar(arriba)"
@onready var saltar_izq_button = $"Console/ScrollContainer/Commands/PopupPanel/HBoxContainer/saltar(izq)"
@onready var saltar_der_button = $"Console/ScrollContainer/Commands/PopupPanel/HBoxContainer/saltar(der)"
@onready var saltar_abajo_button = $"Console/ScrollContainer/Commands/PopupPanel/HBoxContainer/saltar(abajo)"
@onready var rep_2 = $"Console/ScrollContainer/Commands/repetir_popup/HBoxContainer/reps_2"
@onready var rep_3 = $"Console/ScrollContainer/Commands/repetir_popup/HBoxContainer/reps_3"
@onready var rep_4 = $"Console/ScrollContainer/Commands/repetir_popup/HBoxContainer/reps_4"
@onready var rep_5 = $"Console/ScrollContainer/Commands/repetir_popup/HBoxContainer/reps_5"
@onready var rep_6 = $"Console/ScrollContainer/Commands/repetir_popup/HBoxContainer/reps_6"
@onready var rep_7 = $"Console/ScrollContainer/Commands/repetir_popup/HBoxContainer/reps_7"
@onready var rep_8 = $"Console/ScrollContainer/Commands/repetir_popup/HBoxContainer/reps_8"
@onready var rep_9 = $"Console/ScrollContainer/Commands/repetir_popup/HBoxContainer/reps_9"
@onready var repetir_popup = $Console/ScrollContainer/Commands/repetir_popup
@onready var repetir___ = $"Console/ScrollContainer/Commands/repetir(#)"
@onready var repetir_button = $"Console/ScrollContainer/Commands/repetir(#)"
@onready var funcion_crear = $Console/ScrollContainer/Commands/funcionCrear
@onready var func_1_popup = $Console/ScrollContainer/Commands/func1_popup
@onready var crear_1 = $"Console/ScrollContainer/Commands/func1_popup/HBoxContainer/crear1"
@onready var crear_2 = $"Console/ScrollContainer/Commands/func1_popup/HBoxContainer/crear2"
@onready var crear_3 = $"Console/ScrollContainer/Commands/func1_popup/HBoxContainer/crear3"
@onready var crear_4 = $"Console/ScrollContainer/Commands/func1_popup/HBoxContainer/crear4"
@onready var crear_5 = $"Console/ScrollContainer/Commands/func1_popup/HBoxContainer/crear5"
@onready var funcion_usar = $Console/ScrollContainer/Commands/funcionUsar
@onready var func_2_popup = $Console/ScrollContainer/Commands/func2_popup
@onready var usar_1 = $"Console/ScrollContainer/Commands/func2_popup/HBoxContainer/usar1"
@onready var usar_2 = $"Console/ScrollContainer/Commands/func2_popup/HBoxContainer/usar2"
@onready var usar_3 = $"Console/ScrollContainer/Commands/func2_popup/HBoxContainer/usar3"
@onready var usar_4 = $"Console/ScrollContainer/Commands/func2_popup/HBoxContainer/usar4"
@onready var usar_5 = $"Console/ScrollContainer/Commands/func2_popup/HBoxContainer/usar5"
@onready var hint_button = $Options/hint

var level_hint = null
var no_hint_levels = ["Level5","Level6", "Level8", "Level10", "Level11", "Level12", "Level13"]
var curr_level_has_no_hint = null
var buttons = []

func check_hints():
	if curr_level_has_no_hint:
		hint_button.visible = false
	else:
		level_hint = $"../Hint"

### LOOP + FUNCTION LOGIC BEGINS HERE ##
var text_index = 0

func loop_logic(loop_line):
	var repeats = str_to_var(loop_line.lstrip("\t")[8])
	var next_line = text_edit.get_line(text_index + 1)
	var unraveled_commands = []
	var aux_list = []
	var indent_level = text_edit.get_indent_level(text_index + 1)
	while text_edit.get_indent_level(text_index + 1) == indent_level:
		var empty = next_line.is_empty() or next_line.ends_with("\t")
		if next_line.contains("repetir"):
			text_index += 1
			unraveled_commands += loop_logic(next_line)
		elif next_line.contains("def func"):
			def_func_logic(next_line)
		elif next_line.contains("func") and !next_line.contains("def func"):
			var func_name = "func" + next_line[-3]
			if functions.has(func_name):
				unraveled_commands += functions[func_name]
			text_index += 1
		elif !empty:
			unraveled_commands.append(next_line.lstrip("\t"))
			text_index += 1
		else:
			text_index += 1
		next_line = text_edit.get_line(text_index + 1)
	var j = 0
	while j < repeats:
		aux_list += unraveled_commands
		j += 1
	return aux_list

var functions = {}

func def_func_logic(def_func_line):
	#change naming so it automatically increments instead of choosing from buttons
	var func_name = "func" + def_func_line[-4] 
	var func_body = []
	var next_line = text_edit.get_line(text_index + 1)
	var indent_level = text_edit.get_indent_level(text_index + 1)
	
	while text_edit.get_indent_level(text_index + 1) == indent_level:
		var empty = next_line.is_empty() or next_line.ends_with("\t")
		
		if next_line.contains("repetir"):
			text_index += 1
			func_body += loop_logic(next_line)
		elif next_line.contains("def func"):
			text_index += 1
			def_func_logic(next_line) 
		elif !empty:
			func_body.append(next_line.lstrip("\t"))
			text_index += 1
		else:
			text_index += 1
		next_line = text_edit.get_line(text_index + 1)
	functions[func_name] = func_body
	print(functions)
	#return func_body

func line_to_array():
	instructions_list =[]
	var total_lines = text_edit.get_line_count() - 1
	
	while text_index in range(total_lines):
		var curr_line = text_edit.get_line(text_index)
		
		if curr_line.contains("repetir"):
			instructions_list += loop_logic(curr_line)
		elif curr_line.contains("def func"):
			def_func_logic(curr_line)
		elif curr_line.contains("func") and !curr_line.contains("def func"):
			var func_name = "func" + curr_line[-3]
			if functions.has(func_name):
				instructions_list += functions[func_name]
		elif curr_line.contains("si"):
			#if logic
			pass
		else: #normal line
			instructions_list.append(curr_line)
		text_index += 1 #move into else?
	prints("instructions list: ", instructions_list)
	return instructions_list

### COMMANDS
func buttons_pressed():
	for button in buttons:
		##DIFFERENTIATE BETWEEN REPETIR AND FUNC HERE!!!!!!!!!!!!!
		var command = ""
		var current_name = ""+button.name
		if current_name.contains("reps_"):
			command = "repetir " + current_name[-1] + ":"
		elif current_name.contains("funcionCrear"):
			command = "def func" #+ var_to_str(function_number) + "():"
		elif current_name.contains("usar"):
			command = "func" + current_name[-1] + "()"
		elif current_name.contains("if___"):
			command = "if "
		else:
			command = button.name
		button.pressed.connect(self.add_command.bind(command))

## THESE 4 COULD BE OPTIMIZED INTO ONE FUNCTION WITH TWO PARAMETERS vv
func _on_jump_button_pressed():
	popup_panel.set_position(saltar_button.get_global_position())
	popup_panel.popup()

func _on_repetir_pressed():
	repetir_popup.set_position(repetir_button.get_global_position())
	repetir_popup.popup()

func _on_funcion_crear_pressed():
	pass

func _on_funcion_usar_pressed():
	func_2_popup.set_position(funcion_usar.get_global_position())
	func_2_popup.popup()

var function_number = 1
func automatic_func_naming():
	function_number = 1
	var index = 0
	var total_lines = text_edit.get_line_count() - 1
	
	while index in range(total_lines):
		if text_edit.get_line(index).contains("def func"):
			function_number += 1
		index += 1

func indent_creator(index):
	var indent = ""
	var i = 0
	while i in range(index):
		indent += "\t"
		i += 1
	return indent

func add_command(command):
	if not running:
		automatic_func_naming()
		if command.contains("def func"):
			if function_number > 5:
				return
			command = command + var_to_str(function_number) + "():"
		
		var line_number = text_edit.get_caret_line()
		if line_number < get_parent().max_input:
			var curr_line = text_edit.get_line(line_number)
			var requires_indent = curr_line.contains("repetir") or curr_line.contains("def func")
			var empty = curr_line.is_empty() or curr_line.ends_with("\t")
			var indent_level = text_edit.get_indent_level(line_number)/4
			var indents_to_add = ""
			
			prints("indent level: ", indent_level)
			if indent_level > 5:
				return
			
			if !empty:
				line_number += 1
				if requires_indent:
					indents_to_add = "\t" + indent_creator(indent_level)
			if indent_level >= 1 and !requires_indent:
				indents_to_add = indent_creator(indent_level)
				
			text_edit.insert_line_at(line_number,indents_to_add+command)
			
			if command.contains("repetir") or command.contains("def func"):
				indents_to_add += "\t"
				text_edit.insert_line_at(line_number + 1, indents_to_add)
			text_edit.set_caret_line(line_number+1)

### EDIT
func _on_run_pressed():
	if not running:
		print("key_flags" in get_parent())
		global.reset_level(get_parent(), "key_flags" in get_parent())
		text_index = 0
		running = true
		global.data.level_solutions[current_scene][0] = text_edit.get_line_count() - 1
		var instructions = line_to_array()
		global.save_game()
		print("game saved")
		print(global.data.level_solutions[current_scene])
		await character_1.parse_command(instructions)
		print(instructions)
	running = false
		#make sure the character is at initial position before running
	#enviar lista de instrucciones al jugador para ejecutar

func _on_delete_pressed():
	if not running:
		#instructions_list.pop_back()
		var total_length = text_edit.get_line_count()
		var curr_line = text_edit.get_caret_line()
		var prev_line = curr_line
		var prev_line_length = 0
		var caret_position = text_edit.get_caret_column()
		#text_edit.set_line(curr_line,"")
		if total_length-1 == curr_line:
			print("last line. do nothing?")
		elif curr_line == 0 and total_length > 1:
			print("deleting first line")
			text_edit.remove_text(curr_line,0,curr_line+1,0)
			
		elif total_length > 1:
			print("deleting any line")
			if curr_line >=1:
				prev_line = curr_line-1
				prev_line_length = text_edit.get_line(prev_line).length()
			text_edit.remove_text(prev_line,prev_line_length, curr_line, caret_position)
		#update_console()
func _on_restart_pressed():
	character_1.position = get_parent().initial_position
	character_1.flip(false)
	instructions_list = []
	get_tree().reload_current_scene()
	

@onready var transition = $transition

func _ready():
	transition.play("fade_in")
	curr_level_has_no_hint = get_parent().name in no_hint_levels
	buttons = [mover_der_button, mover_izq_button, tomar_llave_button, utilizar_llave_button,saltar_arriba_button,saltar_izq_button,saltar_der_button,saltar_abajo_button, rep_2, rep_3, rep_4, rep_5, rep_6, rep_7, rep_8, rep_9,funcion_crear,usar_1,usar_2,usar_3,usar_4,usar_5]
	buttons_pressed()
	var buttons_main = [mover_der_button, mover_izq_button, saltar_button, tomar_llave_button, utilizar_llave_button, repetir_button, funcion_crear, funcion_usar]
	#print(buttons_main)
	
	# text edit props
	text_edit.virtual_keyboard_enabled = false
	text_edit.scroll_past_end_of_file = false
	text_edit.caret_blink = true
	text_edit.draw_tabs = true
	##KEYWORD COLORS
	#text_edit.add_keyword_color("def", Color(0.78823530673981, 0.9450980424881, 0.419607847929))
	#text_edit.add_keyword_color("")
	master_slider.value = db_to_linear(global.data.volume_settings.master)
	music_slider.value = db_to_linear(global.data.volume_settings.music)
	current_scene = get_tree().current_scene.name
	
	for index in get_parent().active_buttons:
		buttons_main[index].disabled = false
	check_hints()
func _process(_delta):
	### TEXTEDIT BEHAVIOR
	var line_idx = text_edit.get_caret_line()
	var line_length = text_edit.get_line(line_idx).length()
	text_edit.set_caret_line(line_idx)
	text_edit.set_caret_column(line_length)
	if get_parent().panel_up:
		finish_panel.visible = true
	

### OPTIONS

@onready var volume = $Volume

@onready var MASTER_BUS_ID = AudioServer.get_bus_index("Master")
@onready var MUSIC_BUS_ID = AudioServer.get_bus_index("Music")
@onready var SFX_BUS_ID = AudioServer.get_bus_index("SFX")

func _on_hint_pressed():
	sfx_button.play()
	level_hint.visible = !level_hint.visible
	if get_parent().has_method("reset_hint"):
		get_parent().reset_hint()
	if level_hint.visible:
		volume.visible = false
		rating.visible = false
#settings button:
func _on_volume_pressed():
	sfx_button.play()
	volume.visible = !volume.visible
	if volume.visible:
		rating.visible = false
	if !curr_level_has_no_hint:
		level_hint.visible = false


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
	global.data.volume_settings.sfx = linear_to_db(value)
	AudioServer.set_bus_volume_db(SFX_BUS_ID, global.data.volume_settings.sfx)
	AudioServer.set_bus_mute(SFX_BUS_ID, value < 0.05)
	global.save_game()

func _on_main_menu_pressed():
	get_tree().change_scene_to_file("res://Scenes/main_menu.tscn")

@onready var rating = $Rating
func _on_stars_pressed():
	sfx_button.play()
	rating.visible = !rating.visible
	if rating.visible:
		volume.visible = false
	if !curr_level_has_no_hint:
		level_hint.visible = false
