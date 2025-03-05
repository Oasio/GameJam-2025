class_name Lyre

var scene_node = null

func set_scene_parent(node: Node) -> void:
	scene_node = node


func jouer_melodie(player_position: Vector2, direction_balles: Vector2, angle: float) -> void:
	spawn_onde(player_position, direction_balles, angle)



func spawn_onde(player_position: Vector2, direction_balles: Vector2, angle: float) -> void:
	if scene_node == null:
		print("Erreur : Aucun nœud parent défini pour ajouter fusil.")
		return

	var fusil_scene = preload("res://scenes/attaques/FusilPompe.tscn")
	var fusil = fusil_scene.instantiate()

	if fusil:
		fusil.position = player_position + direction_balles * 50
		fusil.rotation = angle
		scene_node.add_child(fusil)

	else:
		print("Erreur : Impossible de créer fusil.")
