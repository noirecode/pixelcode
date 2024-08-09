extends Area2D
var level_scene = ''

func _ready():
	level_scene = get_parent().get_parent()
func _on_body_entered(body):
	if (body.name.contains("Character")):
		level_scene.inside_keybox = true
		level_scene.curr_box = self.name
		body.get_area(self)

func _on_body_exited(body):
	if (body.name.contains("Character")):
		level_scene.inside_keybox = false
