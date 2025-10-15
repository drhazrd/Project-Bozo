extends VBoxContainer


func _on_master_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Master"), linear_to_db(value))
	AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Master"))
	
func _on_music_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("Music"), linear_to_db(value))
	AudioServer.get_bus_volume_db(AudioServer.get_bus_index("Music"))


func _on_sfx_volume_value_changed(value: float) -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), linear_to_db(value))
	AudioServer.get_bus_volume_db(AudioServer.get_bus_index("SFX"))
