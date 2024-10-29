extends Node

var score = 0
@onready var score_label: Label = $scoreLabel

func add_point():
	score += 1
	print(score)
	score_label.text = str(score)+"/ 7"
