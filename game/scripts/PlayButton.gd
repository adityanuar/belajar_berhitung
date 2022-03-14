extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var clickSound = preload("res://sounds/click.wav")

func playClick():
	var streamPlayer = get_tree().get_root().get_node("Control/AudioStreamPlayer2D")
	if !streamPlayer.is_playing():
		streamPlayer.stream = clickSound
		streamPlayer.play()

# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_PlayButton_pressed():
	playClick()
	yield(get_tree().create_timer(0.5), "timeout")
	get_tree().change_scene("res://scenes/materi.tscn")


func _on_ExitButton_pressed():
	get_node("../AnimationPlayer").play("MaskerIn")


func _on_QuizButton_pressed():
	playClick()
	yield(get_tree().create_timer(0.5), "timeout")
	get_tree().change_scene("res://scenes/latihan.tscn")


func _on_ContohButton_pressed():
	playClick()
	yield(get_tree().create_timer(0.5), "timeout")
	get_tree().change_scene("res://scenes/contoh.tscn")



func _on_RealExitButton_pressed():
	get_tree().quit()
