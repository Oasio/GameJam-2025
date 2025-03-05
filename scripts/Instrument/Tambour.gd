class_name Tambour

var scene_node = null
@export var cooldown = 3  # Durée du cooldown en secondes
var is_on_cooldown = false # Indique si le cooldown est actif

func set_scene_parent(node: Node) -> void:
	scene_node = node



func jouer_melodie(player_position: Vector2) -> void:
	if not is_on_cooldown: # Vérifiez si nous sommes en cooldown
		spawn_onde(player_position)



func spawn_onde(player_position: Vector2) -> void:
	if scene_node == null:
		print("Erreur : Aucun nœud parent défini pour ajouter l'onde.")
		return

	var onde_scene = preload("res://scenes/attaques/Bombes.tscn") # Chargez la scène de l'onde
	var onde = onde_scene.instantiate()

	if onde:
		onde.position = player_position
		scene_node.add_child(onde)

	else:
		print("Erreur : Impossible de créer l'onde.")
