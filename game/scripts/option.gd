extends Resource


class_name Option

export var sound_on = true
export var sound_on_text = "On"
export var sound_off_text = "Off"

export var file_location = "user://options.res"


# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass

func load_data(file_name):
	if ResourceLoader.exists(file_name):
		var option = ResourceLoader.load(file_name)
		return option

func save_data(file_name, option):
	var result = ResourceSaver.save(file_name, option)
	return result == OK
