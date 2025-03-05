extends Node2D

@export var spawner1: Node2D
@export var spawner2: Node2D
@export var spawner3: Node2D
@export var spawner4: Node2D

class Vague:
	var poulpes: int
	var slimes: int
	var robots: int

	func _init(poulpes: int, slimes: int, robots: int):
		self.poulpes = poulpes
		self.slimes = slimes
		self.robots = robots

# Waves and spawners
var vagues = [
	Vague.new(0, 1, 0),
	Vague.new(1, 1, 0),
	Vague.new(1, 2, 0),
	Vague.new(2, 2, 1),
	Vague.new(2, 3, 1),
	Vague.new(3, 3, 2),
	Vague.new(3, 1, 2),
	Vague.new(1, 4, 3),
	Vague.new(2, 2, 3),
	Vague.new(1, 5, 2),
	Vague.new(2, 3, 2),
	Vague.new(3, 2, 1),
	Vague.new(1, 4, 3),
	Vague.new(4, 1, 2),
	Vague.new(2, 2, 3),
	Vague.new(1, 5, 1),
	Vague.new(3, 1, 4),
	Vague.new(4, 3, 1),
	Vague.new(3, 4, 2),
	Vague.new(1, 2, 4),
	Vague.new(3, 5, 2)
]

var spawners = []

var vague_actuelle = 0
var poulpe_scene: PackedScene
var slime_scene: PackedScene
var robot_scene: PackedScene
var count_mob

func _ready():
	poulpe_scene = load("res://scenes/enemies/poulpe.tscn")
	slime_scene = load("res://scenes/enemies/slime.tscn")
	robot_scene = load("res://scenes/enemies/robot.tscn")

	spawners = [spawner1, spawner2, spawner3, spawner4]

	# Ensure spawners are set
	for spawner in spawners:
		if spawner == null:
			push_error("Spawner is not assigned.")
	
	$Timer.start(2)
	

func instancier_ennemis(vague: Vague):
	for i in range(vague.poulpes):
		var spawner = spawners[randi() % len(spawners)]
		var poulpe_instance = poulpe_scene.instantiate()
		poulpe_instance.position = spawner.global_position
		add_child(poulpe_instance)

	for i in range(vague.slimes):
		var spawner = spawners[randi() % len(spawners)]
		var slime_instance = slime_scene.instantiate()
		slime_instance.position = spawner.global_position
		add_child(slime_instance)

	for i in range(vague.robots):
		var spawner = spawners[randi() % len(spawners)]
		var robot_instance = robot_scene.instantiate()
		robot_instance.position = spawner.global_position
		add_child(robot_instance)
	count_mob = vague.poulpes + vague.robots + vague.slimes
		

func _on_timer_timeout():
	if vague_actuelle < len(vagues):
		instancier_ennemis(vagues[vague_actuelle])
		vague_actuelle = (vague_actuelle + 1) % len(vagues)
		$Timer.set_wait_time(30)
		$Timer.start()
	else:
		print("All waves cleared!")
