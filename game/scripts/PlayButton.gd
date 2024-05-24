extends TextureButton


# Declare member variables here. Examples:
# var a = 2
# var b = "text"

var clickSound = preload("res://sounds/click.wav")
var option = null

func playClick():
	if option and option.sound_on:
		var streamPlayer = get_tree().get_root().get_node("Control/AudioStreamPlayer2D")
		if !streamPlayer.is_playing():
			streamPlayer.stream = clickSound
			streamPlayer.play()

# Called when the node enters the scene tree for the first time.
func _ready():
	var lOption = Option.new()
	option = lOption.load_data(lOption.file_location)
	if option:
		if option.sound_on:
			update_sound_option_text()
	else:
		var newOption = Option.new()
		newOption.sound_on = true
		lOption.save_data(lOption.file_location, newOption)
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
func update_sound_option_text():
	if option.sound_on:
		$".".get_parent().get_node("SoundButton/Sound_value").text = option.sound_on_text
	else:
		$".".get_parent().get_node("SoundButton/Sound_value").text = option.sound_off_text


func _on_PlayButton_pressed():
	playClick()
	yield(get_tree().create_timer(0.5), "timeout")
	get_tree().change_scene("res://scenes/materi.tscn")


func _on_ExitButton_pressed():
	playClick()
	get_node("../AnimationPlayer").play("MaskerIn")


func _on_QuizButton_pressed():
	playClick()
	yield(get_tree().create_timer(0.5), "timeout")
	get_tree().change_scene("res://scenes/latihan.tscn")


func _on_ContohButton_pressed():
	playClick()
	yield(get_tree().create_timer(0.5), "timeout")
	get_tree().change_scene("res://scenes/contoh.tscn")
	
func _on_KompetensiButton_pressed():
	playClick()
	yield(get_tree().create_timer(0.5), "timeout")
	get_tree().change_scene("res://scenes/kompetensi.tscn")



func _on_RealExitButton_pressed():
	get_tree().quit()


func _on_SoundButton_pressed():
	if option:
		option.sound_on = !option.sound_on
		option.save_data(option.file_location, option)
		update_sound_option_text()
		playClick()
	pass # Replace with function body.
