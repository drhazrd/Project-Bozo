extends Control

@onready var main_buttons = $VBoxContainer1
@onready var options_menu = $OptionsMenu
@onready var menu_music = $MenuMusic
@onready var title = $Title
@onready var bg_panel = $Background
@onready var quit_confirm = $QuitConfirm   # <-- new confirmation dialog

# --- Pulse settings ---
@export var bus_name := "Music"
@export var pulse_strength := 0.25
@export var smoothing_speed := 8.0

# --- Background color settings ---
@export var color_a := Color(0.1, 0.1, 0.15)
@export var color_b := Color(0.3, 0.0, 0.4)
@export var color_c := Color(0.0, 0.3, 0.6)
@export var bg_intensity := 1.5

var base_scale := Vector2.ONE
var analyzer: AudioEffectSpectrumAnalyzerInstance
var current_amplitude := 0.0
var color_phase := 0.0

func _ready():
	options_menu.visible = false
	if not menu_music.playing:
		menu_music.play()
	base_scale = title.scale
	_setup_spectrum_analyzer()

	# Connect the dialog confirm signal
	quit_confirm.connect("confirmed", Callable(self, "_on_quit_confirmed"))

# --- Spectrum setup ---
func _setup_spectrum_analyzer() -> void:
	var bus_index = AudioServer.get_bus_index(bus_name)
	for i in range(AudioServer.get_bus_effect_count(bus_index)):
		var effect = AudioServer.get_bus_effect(bus_index, i)
		if effect is AudioEffectSpectrumAnalyzer:
			analyzer = AudioServer.get_bus_effect_instance(bus_index, i)
			break
	if analyzer == null:
		push_warning("No AudioEffectSpectrumAnalyzer found on bus '%s'" % bus_name)

# --- Visual updates ---
func _process(_delta: float) -> void:
	if analyzer:
		var bass = analyzer.get_magnitude_for_frequency_range(20, 150).length()
		var low_mid = analyzer.get_magnitude_for_frequency_range(150, 400).length()
		var amplitude = (bass + low_mid) * 0.5

		var t = clamp(smoothing_speed * _delta, 0.0, 1.0)
		current_amplitude = lerp(current_amplitude, amplitude, t)

		var scale_factor = 1.0 + current_amplitude * pulse_strength
		title.scale = base_scale * scale_factor
		title.modulate = Color(1, 1, 1, clamp(0.7 + current_amplitude * 2.0, 0.7, 1.0))

		color_phase += _delta * (1.0 + current_amplitude * 10.0)
		var wave = (sin(color_phase) + 1.0) * 0.5
		var base_color = color_a.lerp(color_b, wave)
		var final_color = base_color.lerp(color_c, current_amplitude * bg_intensity)

		if bg_panel is ColorRect:
			bg_panel.color = final_color
		else:
			bg_panel.modulate = final_color

# --- Button logic ---
func _on_start_button_pressed() -> void:
	print("Start Pressed")

func _on_options_button_pressed() -> void:
	print("Options Pressed")
	main_buttons.visible = false
	options_menu.visible = true
	title.visible = false

func _on_quit_button_pressed() -> void:
	print("Quit Pressed")
	quit_confirm.popup_centered()  # show confirmation dialog

func _on_quit_confirmed() -> void:
	print("Quit confirmed.")
	get_tree().quit()

func _on_back_button_pressed() -> void:
	print("Back Pressed")
	options_menu.visible = false
	main_buttons.visible = true
	title.visible = true
