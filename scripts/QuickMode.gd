extends Control
@onready var label_puntos = $LabelPuntos
@onready var progress_bar = $ProgressBarTiempo
@onready var timer = $TimerPregunta
@onready var botones_opciones = [
	$Control/btnOpcion1,
	$Control/btnOpcion2,
	$Control/btnOpcion3,
	$Control/btnOpcion4
]

var operacion: Operacion
var puntos: int = 0
var tiempo_total: float = 15.0
var tiempo_restante: float = 15.0

func _ready():
	generar_nueva_pregunta()
	timer.connect("timeout", Callable(self, "_on_tiempo_agotado"))

func generar_nueva_pregunta():
	operacion = Operacion.new()
	$LabelPregunta.text = operacion.get_pregunta()
	tiempo_restante = tiempo_total
	progress_bar.value = tiempo_total
	timer.start()
	_conectar_botones()

func _conectar_botones():
	var opciones = operacion.get_opciones()
	for i in range(4):
		botones_opciones[i].text = str(opciones[i])
		botones_opciones[i].disconnect_all("pressed")
		botones_opciones[i].connect("pressed", Callable(self, "_on_opcion_presionada").bind(opciones[i]))

func _process(delta):
	if timer.time_left > 0:
		tiempo_restante = timer.time_left
		progress_bar.value = tiempo_restante

func _on_opcion_presionada(respuesta_elegida: int):
	timer.stop()

	if respuesta_elegida == operacion.get_respuesta_correcta():
		puntos += 25
	else:
		puntos -= 10

	label_puntos.text = "Puntos: %d" % puntos
	await get_tree().create_timer(0.5).timeout
	generar_nueva_pregunta()

func _on_tiempo_agotado():
	puntos -= 10
	label_puntos.text = "Puntos: %d" % puntos
	await get_tree().create_timer(0.5).timeout
	generar_nueva_pregunta()
