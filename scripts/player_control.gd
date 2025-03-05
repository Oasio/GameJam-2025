extends CharacterBody2D

const move_speed = 400
const acceleration = 0.25
const max_boost_speed = 800

var previous_direction = Vector2.ZERO
var boost_speed = 0

var flute = null
var tambour = null
var lyre = null

var flute_timer = 0.0
var tambour_timer = 0.0
var lyre_timer = 0.0

var flute_cooldown = 0.5
var tambour_cooldown = 3.0
var lyre_cooldown = 1

var slot = [null, null]

func _ready() -> void:
	flute = load("res://scripts/Instrument/Flute.gd").new()
	flute.set_scene_parent(get_tree().get_root())
	slot.append(flute)
	
	tambour = load("res://scripts/Instrument/Tambour.gd").new()
	tambour.set_scene_parent(get_tree().get_root())
	
	lyre = load("res://scripts/Instrument/Lyre.gd").new()
	lyre.set_scene_parent(get_tree().get_root())
	slot.append(lyre)
	

func _physics_process(delta: float) -> void:
	move_and_slide()

func _process(delta: float) -> void:
	var direction : Vector2 = Vector2.ZERO
	direction.x = Input.get_action_raw_strength("BOUGER_DROITE") - Input.get_action_raw_strength("BOUGER_GAUCHE")
	direction.y = Input.get_action_raw_strength("BOUGER_BAS") - Input.get_action_raw_strength("BOUGER_HAUT")
	
	if direction != Vector2.ZERO:
		if direction == previous_direction:
			if direction.x != 0 and direction.y != 0:
				boost_speed = min(boost_speed + acceleration / 16, (max_boost_speed - move_speed) / 8)
			else:
				boost_speed = min(boost_speed + acceleration, max_boost_speed - move_speed)
		else:
			boost_speed = 0
			
		previous_direction = direction
		velocity = direction * (move_speed + boost_speed)
	else:
		velocity = Vector2.ZERO
	
	var direction_balle = Vector2.ZERO
	var angle = 0
	var angle_lyre = 0
	if Input.is_action_pressed("JOUER_MUSIQUE_HAUT"):
		direction_balle = Vector2(0, -1)
		angle = 180
		angle_lyre = 270
		
	elif Input.is_action_pressed("JOUER_MUSIQUE_BAS"):
		direction_balle = Vector2(0, 1)
		angle_lyre = 90
		
	elif Input.is_action_pressed("JOUER_MUSIQUE_DROITE"):
		direction_balle = Vector2(1, 0)
		angle = 270
		
	elif Input.is_action_pressed("JOUER_MUSIQUE_GAUCHE"):
		direction_balle = Vector2(-1, 0)
		angle = 90
		angle_lyre = 180
		
	if flute_timer > 0:
		flute_timer -= delta

	if tambour_timer > 0:
		tambour_timer -= delta
		
	if lyre_timer > 0:
		lyre_timer -= delta

	if flute and flute_timer <= 0.0 and direction_balle != Vector2.ZERO:
		flute.jouer_melodie(position, direction_balle, angle)
		flute_timer = flute_cooldown
	
	if tambour and tambour_timer <= 0.0 and direction_balle != Vector2.ZERO:
		tambour.jouer_melodie(position)
		tambour_timer = tambour_cooldown
		
	if lyre and lyre_timer <= 0.0 and direction_balle != Vector2.ZERO:
		lyre.jouer_melodie(position, direction_balle, angle_lyre)
		lyre_timer = lyre_cooldown
			
	
