extends Node

var score = 0
@onready var score_label: Label = $"../Player_test/Camera2D/Score_Label"

func add_point():
	score += 1
	print(score)
	#score_label.text = str(score)+" / 15"
