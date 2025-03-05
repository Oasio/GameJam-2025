extends Area2D

@export var speed: float = 300  # Définir la vitesse de la balle

# Direction initiale du mouvement
var initial_direction: Vector2 = Vector2(1, 0)  # Exemple par défaut : vers la droite

func _physics_process(delta: float) -> void:
	position += initial_direction * speed * delta


func Collision(body: Node2D) -> void:
	if body.is_in_group("World_Border") :
		queue_free()
	if body.is_in_group("Enemies") :
		body.take_damage(1)
		print(body.vie)
		queue_free()
