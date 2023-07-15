extends Node2D


# Declare member variables here. Examples:
# var a = 2
# var b = "text"
var currPage = 1

var clickSound = preload("res://sounds/click.wav")

var option = null

func playClick():
	if option and option.sound_on:
		if !$AudioStreamPlayer2D.is_playing():
			$AudioStreamPlayer2D.stream = clickSound
			$AudioStreamPlayer2D.play()


# Called when the node enters the scene tree for the first time.
func _ready():
	$AnimationPlayer.play("1")
	$Control/LeftButton.set("disabled", true)
	var lOption = Option.new()
	option = lOption.load_data(lOption.file_location)
	
func navButtonStatus():
	playClick()
	if currPage == 1:
		$Control/LeftButton.set("disabled", true)
		$Control/RightButton.set("disabled", false)
	elif currPage == 11:
		$Control/LeftButton.set("disabled", false)
		$Control/RightButton.set("disabled", true)
	else:
		$Control/LeftButton.set("disabled", false)
		$Control/RightButton.set("disabled", false)
		
func next():
	if currPage < 11:
		currPage += 1
		$AnimationPlayer.play(str(currPage))
		navButtonStatus()
		
func prev():
	if currPage > 1:
		currPage -= 1
		$AnimationPlayer.play(str(currPage))
		navButtonStatus()

# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_LeftButton_pressed():
	prev()


func _on_RightButton_pressed():
	next()


func _on_HomeButton_pressed():
	get_tree().change_scene("res://scenes/title.tscn")
