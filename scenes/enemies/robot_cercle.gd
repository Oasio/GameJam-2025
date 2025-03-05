extends Area2D

var direction = Vector2.ZERO
var timer = 0.0
var cooldown = 0.7

func _process(delta: float) -> void:
	timer += delta
	if timer >= cooldown:
		queue_free()


func set_direction(direction: Vector2) -> void:
	self.direction = direction


func Collision(body: Node2D) -> void:
	if body.is_in_group("Player"):
		body.take_damage(3)
