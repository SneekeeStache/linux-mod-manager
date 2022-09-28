extends Node
var version=0.1

var games={
	"Xcom 2":{
		"icon":"res://icons/xcom2.png",
		"path":null,
		"modPath":null,
		"modListPath":null,
		"modPathWOTC":null,
		"modListPathWOTC":null
	}
}
var data

func saveList():
	data={
		"version":version,
		"games":games
	}
	var file= File.new()
	file.open("user://data.json",File.WRITE)
	file.store_line(to_json(data))
	file.close()
	return true

func loadList():
	var file=File.new()
	if not file.file_exists("user://data.json"):
		print("no save")
		return false
	file.open("user://data.json",file.READ)
	var text = file.get_as_text()
	data = parse_json(text)
	file.close()
	version=data["version"]
	games=data["games"]
	return true
# Called when the node enters the scene tree for the first time.
func _ready():
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass
