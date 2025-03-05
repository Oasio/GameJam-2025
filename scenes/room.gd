extends Node2D

@onready var menu_parametres = $Menu_parametres
@onready var interface = $Interface
@onready var mort = $"Ecran mort"
@onready var musique = $Musique

signal daddy ()

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	menu_parametres.exit_parametres.connect(on_exit_parametres)
	mort.retour_menu.connect(on_ecran_mort_retour_menu)
	interface.mort.connect(on_death)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if Input.is_action_just_pressed("PAUSE") :
		on_param_button_pressed()


func on_param_button_pressed():
	get_tree().paused = true
	menu_parametres.set_process(true)
	menu_parametres.visible = true

func on_exit_parametres() -> void :
	get_tree().paused = false
	menu_parametres.visible = false
	menu_parametres.set_process(false)


func _on_audio_stream_player_finished() -> void:
	musique.play()

func set_musique(nom : String) -> void :
	match nom : 
		"idle" :
			musique.stream = load("res://ressources/sons/idle_theme.wav")
		"fight" : 
			musique.stream = load("res://ressources/sons/fight_theme.wav")
		_ :
			pass


func on_ecran_mort_retour_menu() -> void:
	daddy.emit()
	queue_free()

func on_death() -> void :
	mort.visible = true
	get_tree().paused = true
