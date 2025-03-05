class_name Assigner_Bouton
extends Control

@onready var label = $HBoxContainer/Label as Label
@onready var button = $HBoxContainer/Button as Button
 	
@export var nom_action : String = "BOUGER_HAUT"
@onready var nom_touche : String = OS.get_keycode_string(InputMap.action_get_events(nom_action)[0].physical_keycode)


# Called when the node enters the scene tree for the first time.
func _ready():
	set_process_unhandled_key_input(false)
	set_texte_label()
	set_texte_bouton()

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func set_texte_label() -> void : 
	label.text = "Non assignée"
	
	match nom_action :
		"BOUGER_HAUT":
			label.text = "monter"
		"BOUGER_BAS":
			label.text = "descendre"
		"BOUGER_DROITE":
			label.text = "aller à droite"
		"BOUGER_GAUCHE":
			label.text = "aller à gauche"
		"PAUSE":
			label.text = "Pause"

func set_texte_bouton() -> void:
	nom_touche = OS.get_keycode_string(InputMap.action_get_events(nom_action)[0].physical_keycode)
	button.text = "%s" % nom_touche

func definir_touche(touche)-> void:

	var old = InputMap.action_get_events(nom_action)[0]
	var action_keycode=touche.physical_keycode
	
	InputMap.action_erase_events(nom_action)
	InputMap.action_add_event(nom_action, touche)
	set_texte_bouton()

	print(nom_action, "deviens ", nom_touche)
	
	for i in get_tree().get_nodes_in_group("changer_touches"):
		if i.nom_action != self.nom_action and i.nom_touche==self.nom_touche :
			InputMap.action_erase_events(i.nom_action)
			InputMap.action_add_event(i.nom_action, old)
			i.set_texte_bouton()
			print(i.nom_action, "deviens ", i.nom_touche, "car échange")

func _on_button_pressed():
	button.text = "Appuyez sur une touche..."
	set_process_unhandled_key_input(true)


func _unhandled_key_input(event):
	definir_touche(event)
	set_process_unhandled_key_input(false)


func _on_hidden():
	set_process_unhandled_key_input(false)
	set_texte_bouton()
