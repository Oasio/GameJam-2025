extends Node

func lire_yaml():
	var fichier = FileAccess.open("res://scenes/vague/vague.yaml", FileAccess.READ)
	if fichier != null:
		var contenu = fichier.get_as_text()
		fichier = null
		var yaml_contenu = parse_yaml(contenu)
		return yaml_contenu
	else:
		print("Erreur lors de la lecture du fichier YAML")
		return null

func parse_yaml(yaml_text):
	# Godot ne prend pas en charge nativement les fichiers YAML.
	# Vous devrez utiliser une bibliothèque externe pour parser les fichiers YAML.
	print("Erreur : Godot ne prend pas en charge nativement les fichiers YAML")
	return null

func _ready():
	var contenu = lire_yaml()
	if contenu:
		print(contenu)
		var vagues = contenu["vagues"]
		for i in range(len(vagues)):
			var vague = vagues[i]
			print("Vague ", i+1)
			print("  Slime : ", vague["slime"])
			print("  Poulpe : ", vague["poulpe"])
			print("  Robot : ", vague["robot"])
