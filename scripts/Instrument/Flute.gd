class_name Flute

var scene_node = null
var balle_template = preload("res://scenes/attaques/Balle.tscn")
var color_index = 0
var color_list = [
	preload("res://ressources/images/note1.png"),
	preload("res://ressources/images/note2.png"),
	preload("res://ressources/images/note3.png"),
	preload("res://ressources/images/note2.png")
]

@export var cooldown = 0.5  # Durée du cooldown en secondes
var is_on_cooldown = false  # Indique si le cooldown est en cours

func set_scene_parent(node: Node) -> void:
	scene_node = node



func _process(delta) -> void:
	pass  # Cette fonction est requise pour que delta fonctionne correctement


func jouer_melodie(player_position: Vector2, direction_balle: Vector2, angle: float) -> void:
	if not is_on_cooldown:  # Vérifiez si nous pouvons tirer
		spawn_balle(player_position, direction_balle, angle)


func spawn_balle(player_position: Vector2, direction_balle: Vector2, angle: float) -> void:
	if scene_node == null:
		print("Erreur : Aucun nœud parent défini pour ajouter la balle.")
		return
	var balle = balle_template.instantiate()
	balle.position = player_position
	balle.initial_direction = direction_balle
	balle.rotation = deg_to_rad(angle)
	color_index = (1 +color_index)% len(color_list) 
	balle.get_node("Sprite2D").texture = color_list[color_index]
	scene_node.add_child(balle)
