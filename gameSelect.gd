extends Control
onready var vbox=$ScrollContainer/VBoxContainer

# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	OS.set_window_size(Vector2(388,486))
	for i in Gamelist.games.keys():
		var gameButton= Button.new()
		gameButton.name=i
		gameButton.expand_icon=true
		vbox.add_child(gameButton)
		gameButton.icon=load(Gamelist.games[i]["icon"])
		gameButton.connect("pressed",self,"_button_pressed",[i])
		gameButton.text=i
		gameButton.ALIGN_RIGHT


func _button_pressed(name):
	if(Gamelist.games[name]["path"]==null):
		var fileBrowser= FileDialog.new()

func _process(delta):
	for i in vbox.get_children():
		i.set_size(Vector2(300,100))
