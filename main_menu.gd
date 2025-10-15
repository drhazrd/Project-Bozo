extends Control
@onready var main_buttons = $VBoxContainer1
@onready var options_menu = $OptionsMenu
@onready var menu_music = $MenuMusic

func _ready():
	options_menu.visible = false
	if not menu_music.playing:
		menu_music.play()

func _on_start_button_pressed() -> void:
	print("Start Pressed")


func _on_options_button_pressed() -> void:
	print("Options Pressed")
	main_buttons.visible = false
	options_menu.visible = true
	$Title.visible = false

func _on_quit_button_pressed() -> void:
	print("Quit Pressed")


func _on_back_button_pressed() -> void:
	print("Back Pressed")
	options_menu.visible = false
	main_buttons.visible = true
	$Title.visible = true
