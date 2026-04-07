extends Node2D

class_name Room3

@onready var game_manager = get_node("/root/Main/GameManager")
@onready var dialogue_system = get_node("/root/Main/DialogueSystem")
@onready var player = $Player

var pool_table_interactions: int = 0
var flower_placed: bool = false
var fireplace_opened: bool = false

func _ready():
	spawn_items()
	setup_pool_table()
	setup_fireplace()

func spawn_items():
	var item_scene = preload("res://scenes/ItemPickup.tscn")
	
	# Flower
	var flower = item_scene.instantiate()
	flower.position = Vector2(960, 300)
	flower.item_id = Constants.ITEMS.FLOWER if not flower_placed else -1
	add_child(flower)

func setup_pool_table():
	# Interactive pool table
	var pool_table = Node2D.new()
	pool_table.position = Vector2(960, 540)
	pool_table.add_to_group("interactable")
	add_child(pool_table)

func setup_fireplace():
	# Interactive fireplace with flower placement
	var fireplace = Node2D.new()
	fireplace.position = Vector2(1700, 400)
	fireplace.add_to_group("fireplace")
	add_child(fireplace)

func _process(_delta):
	# Check for pool cue/balls collection
	if game_manager.inventory_items.has(Constants.ITEMS.POOL_CUE):
		pass
	
	# Check for flower + vase puzzle
	if game_manager.inventory_items.has(Constants.ITEMS.FLOWER) and game_manager.inventory_items.has(Constants.ITEMS.VASE):
		if not flower_placed:
			if dialogue_system:
				dialogue_system.queue_dialogue("Winter", "Let me place this flower in the vase.")
