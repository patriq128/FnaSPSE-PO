
extends Node2D

const NEXT_SCENE := "res://scenes/night/night.tscn"

@onready var sprite: Sprite2D = $Loading
@onready var secret_sprite: Sprite2D = $Secret

const ROTATION_SPEED := 3.0

func _ready() -> void:
	# 1 ku 10 šanca na Secret
	if randi_range(1, 10) == 1:
		secret_sprite.visible = true
		sprite.visible = false
	else:
		secret_sprite.visible = false
		sprite.visible = true

	ResourceLoader.load_threaded_request(NEXT_SCENE)

func _process(delta: float) -> void:
	# Otáčanie viditeľného sprite
	if sprite.visible:
		sprite.rotation += ROTATION_SPEED * delta

	if secret_sprite.visible:
		secret_sprite.rotation += ROTATION_SPEED * delta

	# Kontrola načítania scény
	if ResourceLoader.load_threaded_get_status(NEXT_SCENE) == ResourceLoader.THREAD_LOAD_LOADED:
		var scene := ResourceLoader.load_threaded_get(NEXT_SCENE)
		get_tree().change_scene_to_packed(scene)
