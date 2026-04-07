extends Node2D

class_name Room2

@onready var game_manager = get_node("/root/Main/GameManager")
@onready var dialogue_system = get_node("/root/Main/DialogueSystem")
@onready var player = $Player

var door_unlocked: bool = false

func _ready():
	if dialogue_system:
		dialogue_system.queue_dialogue("Winter", "I don't need the torch anymore.")
	
	# Torch automatically returns to inventory
	game_manager.inventory_items.erase(Constants.ITEMS.TORCH)
	
	spawn_items()
	spawn_doors()

func spawn_items():
	var item_scene = preload("res://scenes/ItemPickup.tscn")
	
	# Phone
	var phone = item_scene.instantiate()
	phone.position = Vector2(400, 300)
	phone.item_id = Constants.ITEMS.FLIP_PHONE
	add_child(phone)
	
	# Notepad
	var notepad = item_scene.instantiate()
	notepad.position = Vector2(800, 400)
	notepad.item_id = Constants.ITEMS.NOTEPAD
	add_child(notepad)
	
	# Candlestick
	var candlestick = item_scene.instantiate()
	candlestick.position = Vector2(600, 300)
	candlestick.item_id = Constants.ITEMS.CANDLESTICK
	add_child(candlestick)
	
	# Wrist watch
	var watch = item_scene.instantiate()
	watch.position = Vector2(1000, 350)
	watch.item_id = Constants.ITEMS.WRIST_WATCH
	add_child(watch)
	
	# Coffee beans
	for i in range(10):
		var bean = item_scene.instantiate()
		bean.position = Vector2(randi() % 1920, randi() % 1080)
		bean.item_id = Constants.ITEMS.COFFEE_BEAN
		add_child(bean)

func spawn_doors():
	# Multiple locked doors, only one opens with playing card
	for i in range(5):
		var door = preload("res://scenes/Door.tscn").instantiate()
		door.position = Vector2(300 + i * 300, 600)
		door.door_id = i
		door.requires_item = Constants.ITEMS.PLAYING_CARD if i == 2 else -1
		door.target_room = "Room3" if i == 2 else ""
		add_child(door)
