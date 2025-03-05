extends Area2D

var timer = 0.0
var cooldown = 0.3

func _process(delta: float) -> void:
	timer += delta
	if timer >= cooldown:
		queue_free()

func Collision(body: Node2D) -> void:
	if body.is_in_group("Enemies") :
		body.take_damage(3)
