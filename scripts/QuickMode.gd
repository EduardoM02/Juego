extends Control

@onready var label_puntos = $LabelPuntos
@onready var progress_bar = $ProgressBarTiempo
@onready var timer = $TimerPregunta
@onready var label_operacion = $LabelOperacion
@onready var anim = $AnimationPlayer
@onready var popup_gameover = $ControlPopup/GameOverPopup
@onready var label_puntaje_final = $ControlPopup/GameOverPopup/VBoxContainer/LabelPuntajeFinal
@onready var btn_volver = $ControlPopup/GameOverPopup/VBoxContainer/HBoxContainer/ButtonVolver
@onready var btn_reintentar = $ControlPopup/GameOverPopup/VBoxContainer/HBoxContainer/ButtonrReintentar
@onready var anim_gameover = $AnimationPlayerGameOver

@onready var textura_correcta = preload("res://Vector/Green/button_rectangle_depth_flat.svg")
@onready var textura_incorrecta = preload("res://Vector/Red/button_rectangle_depth_flat.svg")
@onready var textura_normal = preload("res://Vector/Blue/button_rectangle_depth_flat.svg")

@onready var botones_opciones = [
	$btnOpcion1,
	$btnOpcion2,
	$btnOpcion3,
	$btnOpcion4
]

var operacion: Operacion
var puntos: int = 0
var tiempo_total: float = 15.0

func _ready():
	btn_volver.pressed.connect(_on_volver)
	btn_reintentar.pressed.connect(_on_reintentar)
	
	for boton in botones_opciones:
		boton.pressed.connect(_on_opcion_presionada.bind(boton))

	timer.timeout.connect(_on_tiempo_agotado)
	generar_nueva_pregunta()

func generar_nueva_pregunta():
	operacion = Operacion.new()
	label_operacion.text = operacion.get_pregunta()
	progress_bar.max_value = tiempo_total
	progress_bar.value = tiempo_total
	timer.start()

	var opciones = operacion.get_opciones()
	for i in range(4):
		botones_opciones[i].get_node("Label").text = str(opciones[i])

func _process(delta):
	if timer.is_stopped():
		return
	progress_bar.value = timer.time_left

func _reset_botones():
	for b in botones_opciones:
		b.texture_normal = textura_normal
		b.disabled = false
		b.modulate.a = 0
	label_operacion.modulate.a = 0
	label_operacion.scale = Vector2(0.8, 0.8)

func _on_opcion_presionada(boton):
	timer.stop()

	var texto_boton = boton.get_node("Label").text
	var respuesta_elegida = int(texto_boton)
	var respuesta_correcta = operacion.get_respuesta_correcta()

	if respuesta_elegida == respuesta_correcta:
		boton.texture_normal = textura_correcta
		puntos += 25

		label_puntos.text = "Puntos: %d" % puntos
		for b in botones_opciones:
			b.disabled = true

		await get_tree().create_timer(0.6).timeout
		anim.play("fade_out")
		await anim.animation_finished
		_reset_botones()
		generar_nueva_pregunta()
		anim.play("fade_in_bounce")
	else:
		label_puntos.text = "Puntos: %d" % puntos
		await get_tree().create_timer(0.5).timeout
		mostrar_gameover()

func _on_tiempo_agotado():
	puntos -= 10
	label_puntos.text = "Puntos: %d" % puntos
	await get_tree().create_timer(0.5).timeout
	mostrar_gameover()

func mostrar_gameover():
	label_puntaje_final.text = "Puntaje: %d" % puntos
	ScoreManager.guardar_puntaje(puntos)

	anim_gameover.play("gameover_bounce")
	popup_gameover.show()
	popup_gameover.popup_centered()

func _on_volver():
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")

func _on_reintentar():
	get_tree().reload_current_scene()







#extends Control
#@onready var label_puntos = $LabelPuntos
#@onready var progress_bar = $ProgressBarTiempo
#@onready var timer = $TimerPregunta
#@onready var label_operacion = $LabelOperacion
#@onready var anim = $AnimationPlayer
#@onready var popup_gameover = $GameOverPopup
#@onready var label_puntaje_final = $GameOverPopup/VBoxContainer/LabelPuntajeFinal
#@onready var btn_volver = $GameOverPopup/VBoxContainer/HBoxContainer/ButtonVolver
#@onready var btn_reintentar = $GameOverPopup/VBoxContainer/HBoxContainer/ButtonrReintentar
#@onready var textura_correcta = preload("res://Vector/Green/button_rectangle_depth_flat.svg")
#@onready var textura_incorrecta = preload("res://Vector/Red/button_rectangle_depth_flat.svg")
#@onready var textura_normal = preload("res://Vector/Blue/button_rectangle_depth_flat.svg") # si tienes una
#
#
#@onready var botones_opciones = [
	#$btnOpcion1,
	#$btnOpcion2,
	#$btnOpcion3,
	#$btnOpcion4
#]
#
#var operacion: Operacion
#var puntos: int = 0
#var tiempo_total: float = 15.0
#
#func _ready():
	## Conectar todos los botones a una sola función
	#btn_volver.pressed.connect(_on_volver)
	#btn_reintentar.pressed.connect(_on_reintentar)
	#
	#for boton in botones_opciones:
		#boton.pressed.connect(_on_opcion_presionada.bind(boton))
	#timer.timeout.connect(_on_tiempo_agotado)
	#generar_nueva_pregunta()
#
#func generar_nueva_pregunta():
	#operacion = Operacion.new()
	#label_operacion.text = operacion.get_pregunta()
	#progress_bar.max_value = tiempo_total
	#progress_bar.value = tiempo_total
	#timer.start()
#
	#var opciones = operacion.get_opciones()
	#for i in range(4):
		#botones_opciones[i].get_node("Label").text = str(opciones[i])
#
#func _process(delta):
	#if timer.is_stopped():
		#return
	#progress_bar.value = timer.time_left
	#
#func _reset_botones():
	#for b in botones_opciones:
		#b.texture_normal = textura_normal
		#b.disabled = false
		#b.modulate.a = 0  
	#label_operacion.modulate.a = 0
	#label_operacion.scale = Vector2(0.8, 0.8)
#
#
#func _on_opcion_presionada(boton):
	#timer.stop()
#
	#var texto_boton = boton.get_node("Label").text
	#var respuesta_elegida = int(texto_boton)
	#var respuesta_correcta = operacion.get_respuesta_correcta()
#
	## Marcar el botón presionado con feedback
	#if respuesta_elegida == respuesta_correcta:
		#boton.texture_normal = textura_correcta
		#puntos += 25
	#else:
		#boton.texture_normal = textura_incorrecta
		#puntos -= 10
#
	#label_puntos.text = "Puntos: %d" % puntos
#
	## Desactivar botones
	#for b in botones_opciones:
		#b.disabled = true
#
	#await get_tree().create_timer(0.6).timeout
	#anim.play("fade_out")
	#await anim.animation_finished
	#_reset_botones()
	#generar_nueva_pregunta()
	#anim.play("fade_in_bounce")
#
#
#func _on_tiempo_agotado():
	#
	#puntos -= 10
	#label_puntos.text = "Puntos: %d" % puntos
	#await get_tree().create_timer(0.5).timeout
	#generar_nueva_pregunta()
	#
#func mostrar_gameover():
	#label_puntaje_final.text = "Puntaje: %d" % puntos
	#ScoreManager.guardar_puntaje(puntos)  # Guarda automáticamente si aplica
	#popup_gameover.popup_centered()
#
#func _on_volver():
	#get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
#
#func _on_reintentar():
	#get_tree().reload_current_scene()
