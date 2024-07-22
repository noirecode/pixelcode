extends Control
@onready var panel = $Panel
@onready var label = $Panel/Label
@onready var texture_rect = $Panel/TextureRect

var hint_content = {
	"Level1": {"text": "Bienvenido al mundo de CODEPIXEL.
	En este juego, deberás ayudar a Boti a atravesar un mundo de fantasía en busca de una espada legendaria. Para lograrlo, tendrás que hablarle a Boti en el único lenguaje que conoce: algoritmos y funciones.", "image": ""},
	"Level2": {"text": "This is level two", "image":""},
	"Level3": {"text": "This is level three", "image":""},
	"Level": {"text":"","image": ""}
}

func load_hint():
	var current_scene = get_tree().current_scene.name
	if current_scene in hint_content:
		label.text = hint_content[current_scene].text

func _input(event):
	if event is InputEventScreenTouch and event.is_pressed():
		# Get the global touch position
		var touch_pos = event.position
		# Check if the touch is outside the TextLabel's rect
		if not panel.get_global_rect().has_point(touch_pos):
			self.visible = false

func _ready():
	load_hint()
