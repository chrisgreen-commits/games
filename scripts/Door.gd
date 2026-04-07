extends Area2D

class_name Door

@export var door_id: int = 0
@export var requires_item: int = -1
@export var target_room: String = ""

@onready var sprite = $Sprite2D
@onready var game_manager = get_node("/root/Main/GameManager")
@onready var dialogue_system = get_node("/root/Main/DialogueSystem")

func _ready():
	sprite.texture = load("res://assets/sprites/door.png")

func interact(player_ref: Node2D):
	if requires_item == -1:
		# Door is open
		if target_room:
			game_manager.change_room(target_room)
	else:
		# Check if player has required item
		if game_manager.inventory_items.has(requires_item):
			if dialogue_system:
				dialogue_system.queue_dialogue("Winter", "Hey, maybe I can use this card to pick the lock. It worked!")
			game_manager.change_room(target_room)
		else:
			if dialogue_system:
				dialogue_system.queue_dialogue("Winter", "Hmm, that one's locked.")
