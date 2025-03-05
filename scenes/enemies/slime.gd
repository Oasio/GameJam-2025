extends CharacterBody2D


const SPEED = 100.0
@onready var player = get_parent().get_node("Player_Melodie")
var player_position = Vector2.ZERO
var target_position = Vector2.ZERO

var move_timer = 2
var next_degat = 1
 
var vie = 4

func take_damage(dmg : int) :
	vie -= dmg
	if vie <= 0:
		queue_free()
	

func _physics_process(delta: float) -> void:
	player_position = player.position
	target_position = (player_position - position).normalized()
	move_and_slide()
	next_degat -= delta
	
	for i in get_slide_collision_count():
		var collision = get_slide_collision(i)
		if collision.get_collider_shape().get_instance_id() == player.get_child(1).get_instance_id():
			if next_degat <= 0:
				player.take_damage(2)
				next_degat = 1


func _process(delta: float) -> void:
	var direction : Vector2 
	if move_timer > 0 :
		move_timer -= delta
		direction = Vector2.ZERO
	else : 
		direction = target_position
	
	$AnimatedSprite2D.play("Generic")
	
	velocity = direction * SPEED
