extends Area2D


export (String) var nextLevel

func _on_SceneTrans_body_entered(body):
	if body.is_in_group("player"):
		get_tree().change_scene("res://Scenes/" + nextLevel)
