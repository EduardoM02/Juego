extends Control


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_btn_jugar_pressed() -> void:
	
	$AnimationPlayer.play("btn_hide") 
	await $AnimationPlayer.animation_finished
	get_tree().change_scene_to_file("res://scenes/ModeSelect.tscn")


func _on_btn_puntuacion_pressed() -> void:
	
	get_tree().change_scene_to_file("res://scenes/Scores.tscn")


func _on_btn_salir_pressed() -> void:
	
	get_tree().quit()
