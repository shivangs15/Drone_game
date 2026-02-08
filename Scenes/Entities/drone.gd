extends CharacterBody2D

var direction: Vector2
var speed := 50
var player: CharacterBody2D
var health := 3
var is_exploding: bool = false


func _on_area_2d_body_entered(player_body: Node2D) -> void:
	player = player_body


func _physics_process(_delta: float) -> void:
	if player:
		var dir = (player.position - position).normalized()
		velocity = dir * speed
		move_and_slide()


func _on_area_2d_body_exited(_player_body: CharacterBody2D) -> void:
	player = null


func _on_collision_area_body_entered(_body: Node2D) -> void:
	explode()
	call_deferred('change_scene')


func change_scene():
	get_tree().change_scene_to_file("res://Scenes/menu.tscn")


func hit():
	health -= 1
	if health <=0:
		is_exploding = true
		explode()


func explode():
	$AudioStreamPlayer2D.play()
	speed = 0 
	$AnimatedSprite2D.hide()
	$ExplosionSprite.show()
	$AnimationPlayer.play("explosion")
	await $AnimationPlayer.animation_finished
	queue_free()


func chain_reaction():
	for drone in get_tree().get_nodes_in_group('Drones'):
		if position.distance_to(drone.position) < 20:
			if not is_exploding:
				drone.explode()
