extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var answer = ["c", "c", "b", "c"]
var step = 0
var score = 0


# Called when the node enters the scene tree for the first time.
func _ready():
	$QuestionPlayer.play("1")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
var correctSound = preload("res://sounds/correct.wav")
var wrongSound = preload("res://sounds/wrong.wav")
var victorySound = preload("res://sounds/victory.wav")
var defeatSound = preload("res://sounds/defeat.wav")
var clickSound = preload("res://sounds/click.wav")

func playClick():
	if !$AudioStreamPlayer2D.is_playing():
		$AudioStreamPlayer2D.stream = clickSound
		$AudioStreamPlayer2D.play()
		
func playCorrect():
	if !$AudioStreamPlayer2D.is_playing():
		$AudioStreamPlayer2D.stream = correctSound
		$AudioStreamPlayer2D.play()
		
func playWrong():
	if !$AudioStreamPlayer2D.is_playing():
		$AudioStreamPlayer2D.stream = wrongSound
		$AudioStreamPlayer2D.play()

func playVictory():
	$AudioStreamPlayer2D.stop()
	if !$AudioStreamPlayer2D.is_playing():
		$AudioStreamPlayer2D.stream = victorySound
		$AudioStreamPlayer2D.play()

func playDefeat():
	$AudioStreamPlayer2D.stop()
	if !$AudioStreamPlayer2D.is_playing():
		$AudioStreamPlayer2D.stream = defeatSound
		$AudioStreamPlayer2D.play()

func _on_answer_pressed(extra_arg_0):
	var btnNodeAnswer = "root/{0}/opsi/{1}/cross".format([(step+1), (str(extra_arg_0))], "{_}")
	var btnNodeCorrect = "root/{0}/opsi/{1}/mark".format([(step+1), answer[step]], "{_}")
	if str(extra_arg_0) != answer[step]:
		get_tree().get_root().get_node(btnNodeAnswer).visible = true
		playWrong()
	else:
		score = score + 1
		playCorrect()
	get_tree().get_root().get_node(btnNodeCorrect).visible = true
	yield(get_tree().create_timer(1.0), "timeout")
	if step < 3:
		step = step + 1
		$QuestionPlayer.play(str(step+1))
	else:
		var totalQuestion = answer.size()
		print(score)
		var finalScore = float(score) / float(totalQuestion) * 100
		print(finalScore)
		$rapor/score.text = str(finalScore)
		if finalScore <= 50:
			$rapor/score.add_color_override("font_color",  Color(1, 0, 0))
#			$rapor/score.add_color_override("font_color",  Color(216, 6, 6))
			$rapor/greet.text = "Aduh!"
			$rapor/suggestion.text = "Belajar lebih giat lagi ya!"
			playDefeat()
		elif finalScore < 100:
			$rapor/score.add_color_override("font_color", Color(0, 1, 0))
#			$rapor/score.add_color_override("font_color", Color(74, 255, 0))
			$rapor/greet.text = "Sedikit lagi!"
			$rapor/suggestion.text = "Kedepannya lebih teliti lagi ya!"
			playVictory()
		else:
			$rapor/score.add_color_override("font_color", Color(0, 1, 0))
#			$rapor/score.add_color_override("font_color", Color(74, 255, 0))
			$rapor/greet.text = "Selamat!"
			$rapor/suggestion.text = "Pertahankan prestasimu!"
			playVictory()
		$QuestionPlayer.play("rapor")
	


func _on_OKButton_pressed():
	playClick()
	get_tree().change_scene("res://scenes/title.tscn")
