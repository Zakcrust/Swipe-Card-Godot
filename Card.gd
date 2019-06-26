extends KinematicBody2D

var vel = Vector2()
var target = Vector2()
var direction = 3
var cardList = ["actor","axe","bed","hat","gun",
				"key","mirror","paper","phone","scissor",
				"octopus","ocean","onion","spoon"]
var currentNumber = 0
var id = 0
var img
var answer
export (float) var scale_x = 0.4
export (float) var scale_y = 0.4
onready var sprite = get_node("/root/SwipeCardMain/Card/Sprite")
onready var cardName = get_node("/root/SwipeCardMain/Card/CardName")
onready var cardSpellName = get_node("/root/SwipeCardMain/Card/CardSpellName")

signal correct_answer
#set the first image of card for after loaded
func _ready():
	_setImg(_randomCard())
	
#main process of the card. which is to check the card movement 
#based on screen swipe as input
func _process(delta):
	_move_card(direction)
	position += vel
	if direction != 3:
		direction = 3
		_reset_pos()
		
#function to move the car based on the parameters
func _move_card(direction):
	if direction == 1:
		target = Vector2(40,0)
		vel = target
		print("moved",target,vel)
		#start the timer
		$Timer.start()
	elif direction == 0 :
		target = Vector2(-40,0)
		vel = target
		print("moved",target,vel)
		#start the timer
		$Timer.start()

		
func _set_direction(value):
	direction = value

func _reset_pos():
	position = Vector2(288/2,512/2)

#set the image, image name, and its spelling name. image is taken based on its path
func _setImg(name):
	var img_name = str("res://img/",name,".png")
	img = load(img_name)
	sprite.set_texture(img)
	cardName.set_text(name.capitalize())
	cardSpellName.set_text(name.capitalize())
	answer = name
	#emit_signal("correct_answer")
	var s = Vector2()
	s.x = scale_x
	s.y = scale_y
	#resize the sprite to fit in the card
	sprite.scale = s
	print(img_name)

#return the name of the card based on randomized number between -1 and 14
func _randomCard():
	while(id == currentNumber):
		id = floor(rand_range(-1, 14))
	currentNumber = id
	print(id)
	return cardList[id]
	pass

#function will be called after the time is passed 
func _on_Timer_timeout():
	vel = Vector2()
	_reset_pos()
	_set_direction(3)
	_setImg(_randomCard())


func _on_SwipeDetector_check_answer(condition):
	print(condition)
	var regex = RegEx.new()
	var ans = answer.left(1)
	if(condition==1):
		if(ans == "a"):
			emit_signal("correct_answer")
		elif(ans == "i"):
			emit_signal("correct_answer")
		elif(ans == "u"):
			emit_signal("correct_answer")
		elif(ans == "e"):
			emit_signal("correct_answer")
		elif(ans == "o"):
			emit_signal("correct_answer")
		elif(answer.left(2) == "ho"):
			emit_signal("correct_answer")
		elif(answer.left(2) == "ye"):
			emit_signal("correct_answer")
	else:
		regex.compile("^u+[a-z]i")
		regex.search(answer)
		if(ans == "a"):
			pass
		elif(ans == "i"):
			pass
		elif(ans == "u"):
			pass
		elif(ans == "e"):
			pass
		elif(ans == "o"):
			pass
		elif(regex.get_group_count()>0):
			emit_signal("correct_answer")
		else:
			emit_signal("correct_answer")
