extends Area2D

func _on_body_entered(body):
	if (body.name == "Character1"):
		get_parent().inside_key = true
		get_parent().curr_key = self.name
		body.get_area(self)
		print("entered key body")

func _on_body_exited(body):
	if (body.name == "Character1"):
		get_parent().inside_key = false
		print("left key body")
