extends Node

# Declare member variables here. Examples:
# var a = 2
# var b = "text"
onready var card = get_node("/root/SwipeCardMain/Card")
var elapsed_time = 0
var start
var speed
var start_time
var direction
var length

signal check_answer(condition)

#it checks when the screen is touching and calculate the speed direction and length of the input
func _input(event):
	if event is InputEventMouseButton:
		if event.is_pressed():
			start = event.position
			start_time = elapsed_time
		else :
			direction = event.position - start
			speed = (direction.length() / (elapsed_time - start_time))
			length = direction.x
			direction = direction.normalized()
			print(direction,speed)
			print(length)
			if(start.x > 150 and start.x <425):
				if(event.position.y > 150 and event.position.y < 800):
					if(abs(length) >100):
						_setInputMode(false)
						get_node("/root/SwipeCardMain/CardSlide").play()
						get_node("/root/SwipeCardMain/Card").direction = _get_move_direction(direction)
						if(length>100):
							#1 = an
							emit_signal("check_answer",1)
							print("an")
						else:
							#0 = a
							print("a")
							emit_signal("check_answer",0)
			#instance._set_direction(_get_move_direction(direction))
#calculate elapsed time per frame
func _process(delta):
    elapsed_time += delta
	
#return a value based of the conditions, if the direction more than 0.9 it will return 1
# and it gives signal to card to move right. and vice versa
func _get_move_direction(direction):
	if direction.x > 0.9:
		return 1
	elif direction.x < -0.9 :
		return 0

func _setInputMode(condition):
	get_tree().get_root().set_disable_input(!condition)

func _on_Node2D_start_game():
	get_tree().get_root().set_disable_input(false)
	pass # Replace with function body.


func _on_Card_wake_input():
	_setInputMode(true)
	pass # Replace with function body.
