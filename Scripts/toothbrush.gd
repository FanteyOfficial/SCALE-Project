extends Area2D

func init(start_position):
	set_position(start_position)
	position.y -= 25

func kill():
	queue_free()


func _on_body_entered(body):
	print(body.name)
