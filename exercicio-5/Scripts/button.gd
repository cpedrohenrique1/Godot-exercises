extends Control

func _ready():
	$Button.pressed.connect(_on_button_pressed)

func _on_button_pressed():
	await get_tree().change_scene_to_file("res://Cenas/Formas.tscn")
