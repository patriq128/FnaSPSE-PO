
extends Node2D

const NEXT_SCENE := "res://scenes/night/night.tscn"
@onready var sprite: Sprite2D = $Loading

const ROTATION_SPEED := 3.0

func _ready() -> void:
	ResourceLoader.load_threaded_request(NEXT_SCENE)

func _process(delta: float) -> void:
	# Otáčanie sprite počas načítavania
	sprite.rotation += ROTATION_SPEED * delta

	# Kontrola načítania scény
	if ResourceLoader.load_threaded_get_status(NEXT_SCENE) == ResourceLoader.THREAD_LOAD_LOADED:
		var scene := ResourceLoader.load_threaded_get(NEXT_SCENE)
		get_tree().change_scene_to_packed(scene)
