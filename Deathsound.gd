extends AudioStreamPlayer2D


func _on_Deathsound_finished():
	queue_free()
