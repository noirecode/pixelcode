extends CanvasLayer
@onready var label_1 = $Panel/label_1
@onready var label_2 = $Panel/label_2
@onready var label_3 = $Panel/label_3

func _ready():
	var lineas = " lineas"
	label_1.text = str(global.data.level_solutions[get_parent().get_parent().name][1][2]) + lineas
	label_2.text = str(global.data.level_solutions[get_parent().get_parent().name][1][1]) + lineas
	label_3.text = str(global.data.level_solutions[get_parent().get_parent().name][1][0]) + lineas
