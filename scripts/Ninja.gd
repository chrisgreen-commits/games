extends CharacterBody2D

class_name Ninja

@export var speed: float = 150.0
@export var health: int = 3

var player: Node2D = null
var room: Node2D = null
var velocity: Vector2 = Vector2.ZERO

func _ready():
	add_to_group("enemy")

func _physics_process(delta):
	if player:
		var direction = (player.global_position - global_position).normalized()
		velocity = direction * speed
	
	move_and_slide(velocity)

func take_damage(amount: int):
	health -= amount
	if health <= 0:
		if room:
			room.ninja_defeated()
		queue_free()

func kick_player(player_ref: Node2D):
	if player_ref.has_method("take_damage"):
		player_ref.take_damage(1)
