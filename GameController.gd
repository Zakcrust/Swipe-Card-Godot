extends Node

#onready var scoreLabel = get_node("ScoreLabel")
#onready var levelLabel = get_node("LevelLabel")
var scoreLabel
var levelLabel

var score = 0
var level = 0

# Called when the node enters the scene tree for the first time.
func _ready():
	scoreLabel = get_node("ScoreLabel")
	levelLabel = get_node("LevelLabel")
	_setScore()

func _setScore():
	scoreLabel.set_text(str(score))

func _setLevel(level):
	levelLabel.set_text(level)
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func _on_Card_correct_answer():
	score += 1
	print("score added")
	_setScore()
	pass # Replace with function body.
