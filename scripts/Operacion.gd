# scripts/Operacion.gd
class_name Operacion

var operando1: int
var operando2: int
var operador: String
var resultado_correcto: int
var opciones: Array[int]

func _init():
	
	generar_operacion()

func generar_operacion():
	
	var operadores = ["+", "-", "*", "/"]
	operador = operadores[randi() % operadores.size()]

	match operador:
		"+":
			operando1 = randi() % 50 + 1
			operando2 = randi() % 50 + 1
			resultado_correcto = operando1 + operando2
		"-":
			operando1 = randi() % 50 + 1
			operando2 = randi() % operando1 + 1 # evita negativos
			resultado_correcto = operando1 - operando2
		"*":
			operando1 = randi() % 12 + 1
			operando2 = randi() % 12 + 1
			resultado_correcto = operando1 * operando2
		"/":
			operando2 = randi() % 10 + 1
			resultado_correcto = randi() % 10 + 1
			operando1 = operando2 * resultado_correcto
			# Así la división da exacta
			resultado_correcto = operando1 / operando2

	generar_opciones()

func generar_opciones():
	
	opciones = []
	opciones.append(resultado_correcto)

	while opciones.size() < 4:
		
		var fake = resultado_correcto + randi() % 20 - 10
		
		if fake != resultado_correcto and fake not in opciones and fake >= 0:
			
			opciones.append(fake)

	opciones.shuffle()

func get_pregunta() -> String:
	
	return "%d %s %d" % [operando1, operador, operando2]

func get_opciones() -> Array[int]:
	
	return opciones

func get_respuesta_correcta() -> int:
	
	return resultado_correcto
