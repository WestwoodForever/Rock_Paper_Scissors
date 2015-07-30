
extends Node2D

# member variables here, example:
# var a=2
# var b="textvar"

var lose
var draw
var numberShowTime = 0.05
var lastTime = 0
var numbers = []
var showNumberIndex = 0
var resultCoinIndex = -1
var totalWinShowtTime = 1.5
var accumulatedWinShowTime = 0
var main

func _ready():
	# Initialization here
	lose = get_node("Lose")
	draw = get_node("Draw")
	
	numbers = [0,0,0,0,0,0,0,0,0,0,0,0]
	
	var numbersNode = get_node("Numbers")
	var numberCount = numbersNode.get_child_count()
	
	for i in range(numberCount):
		numbers[i] = numbersNode.get_child(i)
	
	main = get_node("/root/Main")
	
func _process(delta):
	accumulatedWinShowTime += delta
	lastTime += delta
	if lastTime >= numberShowTime:
		numbers[showNumberIndex].hide()
		showNumberIndex += 1
		lastTime = 0
	
	if showNumberIndex >= numbers.size():
		showNumberIndex = 0
		
	numbers[showNumberIndex].show()
		
	if accumulatedWinShowTime > totalWinShowtTime and showNumberIndex == resultCoinIndex:
		set_process(false)
		accumulatedWinShowTime = 0
		showNumberIndex = -1
		setResultCoin(-1)
	
func showDashBoard(iJudgement):
	# win
	if iJudgement == 1:
		set_process(true);
	# lose
	elif iJudgement == 0:
		lose.show()
	# draw
	else:
		draw.show()
		
func setResultCoin(iResultIndex):
	resultCoinIndex = iResultIndex