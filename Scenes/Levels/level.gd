extends Node2D
var bullet_scene = preload("res://Scenes/Bullets/bullet.tscn")


func _ready() -> void:
	$AudioStreamPlayer.play()
	var light_tween = create_tween()
	light_tween.set_loops()
	light_tween.tween_property($PointLight2D2, "energy", 1.5, 1.0)
	light_tween.tween_property($PointLight2D2, "energy", 0.5, 1.0)


func _on_player_shoot(pos: Vector2, dir: Vector2) -> void:
	var bullet = bullet_scene.instantiate() as Area2D
	$Bullets.add_child(bullet)
	bullet.setup(pos,dir)
