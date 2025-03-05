extends Control

@onready var menu_principal = $Menu_principal
@onready var menu_parametres = $Menu_parametres
@onready var musique_fond = $MusiqueFond

var first_room = preload("res://scenes/Room.tscn").instantiate()

func _ready():
	menu_parametres.exit_parametres.connect(on_exit_parametres)
	first_room.daddy.connect(on_daddy)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass


func _on_quit_button_pressed():
	"""
	Entrée : Rien
	Sortie : Rien
	Action : Termine le programme
	"""
	get_tree().quit()


func _on_param_button_pressed():
	menu_principal.visible = false
	menu_parametres.set_process(true)
	menu_parametres.visible = true

func on_exit_parametres() -> void :
	menu_principal.visible = true 
	menu_parametres.visible = false
	menu_parametres.set_process(false)
	


func _on_play_button_pressed():
	get_tree().root.add_child(first_room)
	musique_fond.playing = false
	menu_principal.visible = false



func _on_musique_fond_finished() -> void:
	musique_fond.play()

func on_daddy () -> void :
	musique_fond.playing = true
	menu_principal.visible = true
	first_room = preload("res://scenes/Room.tscn").instantiate()
	first_room.daddy.connect(on_daddy)
