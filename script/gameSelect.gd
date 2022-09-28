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
	if(Gamelist.loadList()):
		print("loaded")
	else:
		print("not loaded")
	


func _button_pressed(name):
	print(Gamelist.games[name]["path"])
	if(Gamelist.games[name]["path"]==null):
		var OkPopUP= AcceptDialog.new()
		get_tree().get_current_scene().add_child(OkPopUP)
		OkPopUP.popup_centered()
		OkPopUP.rect_position=Vector2(44,216)
		OkPopUP.popup_exclusive=true
		OkPopUP.dialog_text="please select the folder of "+name
		OkPopUP.connect("confirmed",self,"okPopFunc",[OkPopUP,name])
	else:
		get_tree().change_scene("res://scene/xcom2.tscn")
		

func _process(delta):
	for i in vbox.get_children():
		i.set_size(Vector2(300,100))

func okPopFunc(OkPopUp,name):
	OkPopUp.queue_free()
	OS.set_window_size(Vector2(800,500))
	var fileBrowser= FileDialog.new()
	get_tree().get_current_scene().add_child(fileBrowser)
	fileBrowser.visible=true
	fileBrowser.rect_size=Vector2(800,500)
	fileBrowser.access=2
	fileBrowser.mode=2
	fileBrowser.connect("dir_selected",self,"locationSelected",[name])
	fileBrowser.connect("hide",self,"closePopUp",[fileBrowser])
	
func locationSelected(path,name):
	var popUpMissing=AcceptDialog.new()
	get_tree().get_current_scene().add_child(popUpMissing)
	popUpMissing.connect("confirmed",self,"closeMissing",[popUpMissing])
	match name:
		"Xcom 2":
			var directory=Directory.new()
			var file=File.new()
			if(Gamelist.games[name]["path"]==null or Gamelist.games[name]["modPath"]==null or Gamelist.games[name]["modListPath"]==null ):
				if(directory.dir_exists(path+"/XComGame/Mods")):
					print("test")
					if(file.file_exists(path+"/XComGame/Config/DefaultModOptions.ini")):
						if(directory.dir_exists(path+"/XCom2-WarOfTheChosen")):
							if(directory.dir_exists(path+"/XCom2-WarOfTheChosen/XComGame/Mods")):
								if(file.file_exists(path+"/XCom2-WarOfTheChosen/XComGame/Config/DefaultModOptions.ini")):
									Gamelist.games[name]["path"]=path
									Gamelist.games[name]["modPath"]= path+"/XComGame/Mods"
									Gamelist.games[name]["modListPath"]= path+"/XComGame/Config/DefaultModOptions.ini"
									Gamelist.games[name]["modPathWOTC"]=path+"XCom2-WarOfTheChosen/XComGame/Mods"
									Gamelist.games[name]["modListPathWOTC"]=path+"XCom2-WarOfTheChosen/Config/DefaultModOptions.ini"
									Gamelist.saveList()
								else:
									print("testWOTC")
									popUpMissing.dialog_text="Missing mod config file for War Of The Chosen"
									popUpMissing.popup_centered()
									popUpMissing.rect_position=Vector2(40,216)
							else:
								print("testWOTC")
								popUpMissing.dialog_text="Missing Mods Folder for War Of The Chosen"
								popUpMissing.popup_centered()
								popUpMissing.rect_position=Vector2(20,216)
						else:
							var popUpWOTCMissing=AcceptDialog.new()
							OS.set_window_size(Vector2(800,500))
							get_tree().get_current_scene().add_child(popUpWOTCMissing)
							popUpWOTCMissing.dialog_text="War Of The Chosen not install, War of the chosen tab will be disabled"
							popUpWOTCMissing.popup_centered()
							popUpWOTCMissing.rect_position=Vector2(20,216)
							popUpWOTCMissing.connect("confirmed",self,"closeMissingWOTC")
							Gamelist.games[name]["path"]=path
							Gamelist.games[name]["modPath"]= path+"/XComGame/Mods"
							Gamelist.games[name]["modListPath"]= path+"/XComGame/Config/DefaultModOptions.ini"
						
					else:
						popUpMissing.dialog_text="Missing Mods Folder"
						popUpMissing.popup_centered()
						popUpMissing.rect_position=Vector2(44,216)
				else:
					popUpMissing.dialog_text="Missing mod config file"
					popUpMissing.popup_centered()
					popUpMissing.rect_position=Vector2(44,216)
			else:
				print("test")
				get_tree().change_scene("res://scene/xcom2.tscn")
		
func closePopUp(fileBrowserPop):
	fileBrowserPop.queue_free()
	OS.set_window_size(Vector2(388,486))
	
func closeMissing(MissingPop):
	MissingPop.queue_free()
	
func closeMissingWOTC():
	Gamelist.saveList()
	get_tree().change_scene("res://scene/xcom2.tscn")
