extends Node

var max_puntajes = 5

func guardar_puntaje (puntos: int):
	
	var data = cargar_puntajes()
	data.append(puntos)
	data.sort()
	data.reverse()
	
	if data.size() > max_puntajes:
		
		data = data.slice(0, max_puntajes)
		
	var file = FileAccess.open("user://puntos.json", FileAccess.WRITE)
	file.store_string(JSON.stringify(data))
	file.close()
	
	
func cargar_puntajes() -> Array:
	
	if FileAccess.file_exists("user://puntos.json"):
		
		var file = FileAccess.open("user://puntos.json", FileAccess.READ)
		var json_text = file.get_as_text()
		var result = JSON.parse_string(json_text)
		
		if typeof(result) == TYPE_ARRAY:
			
			return result
	
	return []
