extends CharacterBody2D

const SPEED = 50.0
@onready var player = get_parent().get_node("Player_Melodie")
var player_position = Vector2.ZERO
var target_position = Vector2.ZERO

var move_timer = 1
 
var vie = 3
var balle = null
var Balle = null

func _ready() -> void:
	Balle = load("res://scenes/enemies/poulpeBullet.tscn")


func take_damage(dmg : int) :
	vie -= dmg
	if vie <= 0:
		queue_free()
	

func _physics_process(delta: float) -> void:
	player_position = player.position
	target_position = (player_position - position).normalized()
	move_and_slide()


func _process(delta: float) -> void:
	var direction : Vector2 
	move_timer -= delta

	if move_timer < 0:
		attaquer_joueur()
		move_timer = 1
		
	
	$AnimatedSprite2D.play("Generic")
	
	velocity = target_position * SPEED * -1


func attaquer_joueur() -> void:
	$AnimatedSprite2D.play("Attack")
	balle = Balle.instantiate()
	balle.set_direction(target_position)
	balle.position = position
	get_parent().add_child(balle)
