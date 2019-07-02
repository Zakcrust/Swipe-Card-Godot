extends Node


signal start_game
# Called when the node enters the scene tree for the first time.
func _ready():
	$ColorRect/AnimationPlayer.play("PointerAnim")
	#get_tree().paused = true
	pass # Replace with function body.

func _input(event):
	if event is InputEventMouseButton:
		$Timer.start()
# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_Timer_timeout():
	queue_free()
	get_tree().paused = false
	pass # Replace with function body.
