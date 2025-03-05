extends Area2D

var speed = 200.0
var direction = Vector2.ZERO

func _process(delta: float) -> void:
	position += direction * speed * delta

func set_direction(direction: Vector2) -> void:
	self.direction = direction


func Collision(body: Node2D) -> void:
	if body.is_in_group("World_Border") :
		queue_free()
	if body.is_in_group("Player"):
		body.take_damage(3)
		queue_free()
		
	
