extends Area2D

func _on_body_entered(body):
	if (body.name.contains("Character")):
		get_parent().inside_keybox = true
		get_parent().curr_box = self.name
		body.get_area(self)

func _on_body_exited(body):
	if (body.name.contains("Character")):
		get_parent().inside_keybox = false
