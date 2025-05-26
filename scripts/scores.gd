extends Control

@onready var contenedor = $MarginContainer/contenedor_tabla

func _ready():
	var puntajes = ScoreManager.cargar_puntajes()

	# Crear fila de encabezado
	var cabecera = crear_fila("Posición", "Puntos", false, true)
	contenedor.add_child(cabecera)

	# Crear filas de puntajes
	for i in range(puntajes.size()):
		var fila = crear_fila("%d°" % (i + 1), "%d" % puntajes[i], i % 2 == 0)
		contenedor.add_child(fila)

func crear_fila(pos_text: String, pts_text: String, sombreado: bool = false, bold: bool = false) -> PanelContainer:
	var fila_panel = PanelContainer.new()
	fila_panel.size_flags_horizontal = Control.SIZE_EXPAND_FILL

	if sombreado:
		var estilo = StyleBoxFlat.new()
		estilo.bg_color = Color(0.9, 0.9, 0.9)
		fila_panel.add_theme_stylebox_override("panel", estilo)

	var fila = HBoxContainer.new()
	fila.size_flags_horizontal = Control.SIZE_EXPAND_FILL

	var col1 = Label.new()
	col1.text = pos_text
	col1.size_flags_horizontal = Control.SIZE_EXPAND
	col1.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	col1.add_theme_font_size_override("font_size", 50)
	if bold:
		col1.add_theme_color_override("font_color", Color.WHITE)
	else:
		col1.add_theme_color_override("font_color", Color(0.2, 0.2, 0.2))

	var col2 = Label.new()
	col2.text = pts_text
	col2.size_flags_horizontal = Control.SIZE_EXPAND
	col2.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	col2.add_theme_font_size_override("font_size", 50)
	if bold:
		col2.add_theme_color_override("font_color", Color.WHITE)
	else:
		col2.add_theme_color_override("font_color", Color(0.2, 0.2, 0.2))

	fila.add_child(col1)
	fila.add_child(col2)
	fila_panel.add_child(fila)

	return fila_panel



#extends Control
#
#@onready var contenedor = $MarginContainer/contenedor_tabla
#
#func _ready():
	#var puntajes = ScoreManager.cargar_puntajes()
#
	## Crear fila de encabezado
	#var cabecera = crear_fila("Posición", "Puntos",false, true)
	#contenedor.add_child(cabecera)
#
	## Crear filas de puntajes
	#for i in range(puntajes.size()):
		#var fila = crear_fila("%d°" % (i + 1), "%d" % puntajes[i], i % 2 == 0)
		#contenedor.add_child(fila)
#
#func crear_fila(pos_text: String, pts_text: String, sombreado: bool = false, bold: bool = false) -> HBoxContainer:
#
	#var fila = HBoxContainer.new()
	#fila.size_flags_horizontal = Control.SIZE_EXPAND_FILL
#
	#var col1 = Label.new()
	#col1.text = pos_text
	#col1.size_flags_horizontal = Control.SIZE_EXPAND
	#col1.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	#col1.add_theme_font_size_override("font_size", 50)
	#if bold:
		#col1.add_theme_color_override("font_color", Color.WHITE)
	#else:
		#col1.add_theme_color_override("font_color", Color(0.2, 0.2, 0.2))
#
	#var col2 = Label.new()
	#col2.text = pts_text
	#col2.size_flags_horizontal = Control.SIZE_EXPAND
	#col2.horizontal_alignment = HORIZONTAL_ALIGNMENT_CENTER
	#col2.add_theme_font_size_override("font_size", 50)
	#if bold:
		#col2.add_theme_color_override("font_color", Color.WHITE)
	#else:
		#col2.add_theme_color_override("font_color", Color(0.2, 0.2, 0.2))
#
	#if sombreado:
		#fila.add_theme_style_override("panel", StyleBoxFlat.new())
		#fila.get_theme_stylebox("panel").bg_color = Color(0.9, 0.9, 0.9)
#
	#fila.add_child(col1)
	#fila.add_child(col2)
	#return fila


func _on_btn_menu_pressed() -> void:
	
	get_tree().change_scene_to_file("res://scenes/MainMenu.tscn")
