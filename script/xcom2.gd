extends Control

onready var xcom2List=$"%xcom 2 list"
# Declare member variables here. Examples:
# var a = 2
# var b = "text"


# Called when the node enters the scene tree for the first time.
func _ready():
	OS.set_window_size(Vector2(1000,600))
	modList()

	

func modList():
	var position=0
	var files= []
	var mods=[]
	var modsPictures=[]
	var dir = Directory.new()
	if Gamelist.games["Xcom 2"]["modPathWOTC"] != null && Gamelist.games["Xcom 2"]["modListPathWOTC"] != null:
		dir.open(Gamelist.games["Xcom 2"]["modPath"])
		dir.list_dir_begin()
		while true:
			var file = dir.get_next()
			if file == "":
				break
			else:
				files.append(file)
		dir.list_dir_end()
		
		for i in files:
			dir.open(Gamelist.games["Xcom 2"]["modPath"]+"/"+i)
			dir.list_dir_begin()
			while true:
				var file = dir.get_next()
				if file == "":
					break
				elif file.get_extension()=="XComMod":
					mods.append(file)
				elif file.get_extension()=="png" or file.get_extension()=="jpg":
					modsPictures.append(file)
			dir.list_dir_end()
				
		for i in mods:
			print(i)
			var container =HBoxContainer.new()
			var mod=CheckBox.new()
			var picture= TextureRect.new()
			xcom2List.add_child(container)
			container.add_child(picture)
			container.add_child(mod)
			container.set("custom_constants/separation",110)
			var image= Image.new()
			image.load(Gamelist.games["Xcom 2"]["modPath"]+"/"+files[position+2]+"/"+modsPictures[position])
			var t= ImageTexture.new()
			t.create_from_image(image)
			picture.texture=t
			picture.rect_scale=Vector2(0.02,0.02)
			
			mod.name=i
			mod.text=i
			position+=1
			
	else:
		pass


