extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var answer = ["d", "d", "a"]
var step = 0

var correctSound = preload("res://sounds/correct.wav")
var wrongSound = preload("res://sounds/wrong.wav")
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


# Called when the node enters the scene tree for the first time.
func _ready():
	$QuestionPlayer.play("1")


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_answer_pressed(extra_arg_0):
	var btnNodeAnswer = "root/{0}/opsi/{1}/cross".format([(step+1), (str(extra_arg_0))], "{_}")
	var btnNodeCorrect = "root/{0}/opsi/{1}/mark".format([(step+1), answer[step]], "{_}")
	if str(extra_arg_0) != answer[step]:
		get_tree().get_root().get_node(btnNodeAnswer).visible = true
		playWrong()
	else:
		playCorrect()
	get_tree().get_root().get_node(btnNodeCorrect).visible = true
	yield(get_tree().create_timer(1.0), "timeout")
	$OpsiPlayer.play(str(step+1))

func _on_ok_pressed():
	playClick()
	if step < 2:
		step = step + 1
		$QuestionPlayer.play(str(step+1))
	else:
		$QuestionPlayer.play("masker")
