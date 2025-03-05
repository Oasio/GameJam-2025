extends Control

@onready var coeur1 = $VBoxContainer/HBoxContainer/TextureRect1
@onready var coeur2 = $VBoxContainer/HBoxContainer/TextureRect2
@onready var coeur3 = $VBoxContainer/HBoxContainer/TextureRect3
@onready var coeur4 = $VBoxContainer/HBoxContainer/TextureRect4
@onready var coeur5 = $VBoxContainer/HBoxContainer/TextureRect5
#Les coeurs, 1 étant le plus à gauche et 5 le plus à droite

@onready var slot1 = $VBoxContainer/HBoxContainer2/TextureRect
@onready var slot2 = $VBoxContainer/HBoxContainer2/TextureRect2

@onready var life : int = 10

signal mort ()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func set_life(pv : int) -> void :
	var step = 1
	if pv < life :
		step = -1
	for i in range(life, pv, step):
		update_life(i)
	update_life(pv)

func update_life (pv : int) -> void :
	match pv :
		0 : 
			coeur1.hide()
			mort.emit()
		1 :
			coeur1.texture = load("res://ressources/images/half_heart.svg")
		2 : 
			coeur1.texture = load("res://ressources/images/full_heart.svg")
			coeur2.hide()
		3 : 
			coeur2.texture = load("res://ressources/images/half_heart.svg")
			coeur2.show()
		4 : 
			coeur2.texture = load("res://ressources/images/full_heart.svg")
			coeur3.hide()
		5 : 
			coeur3.texture = load("res://ressources/images/half_heart.svg")
			coeur3.show()
		6 : 
			coeur3.texture = load("res://ressources/images/full_heart.svg")
			coeur4.hide()
		7 : 
			coeur4.texture = load("res://ressources/images/half_heart.svg")
			coeur4.show()
		8 : 
			coeur4.texture = load("res://ressources/images/full_heart.svg")
			coeur5.hide()
		9 : 
			coeur5.texture = load("res://ressources/images/half_heart.svg")
			coeur5.show()
		10 : 
			coeur5.texture = load("res://ressources/images/full_heart.svg")
		_ : 
			return
	
	life = pv


func update_instrument (listeInstrument : Array) -> void :
	if len(listeInstrument) < 2 :
		slot1.texture = load("res://ressources/images/empty_slot.svg")
		slot2.texture = load("res://ressources/images/empty_slot.svg")
		
	match listeInstrument[0] : 
		"flute" :
			slot1.texture = load("res://ressources/images/flute.svg")
		"tambour" : 
			slot1.texture = load("res://ressources/images/tambour.svg")
		"lyre" : 
			slot1.texture = load("res://ressources/images/lyre.svg")
		_ :
			slot1.texture = load("res://ressources/images/empty_slot.svg")

	match listeInstrument[1] : 
		"flute" :
			slot2.texture = load("res://ressources/images/flute.svg")
		"tambour" : 
			slot2.texture = load("res://ressources/images/tambour.svg")
		"lyre" : 
			slot2.texture = load("res://ressources/images/lyre.svg")
		_ :
			slot2.texture = load("res://ressources/images/empty_slot.svg")
