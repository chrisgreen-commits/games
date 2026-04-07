extends Node2D

class_name Room1

@onready var game_manager = get_node("/root/Main/GameManager")
@onready var dialogue_system = get_node("/root/Main/DialogueSystem")
@onready var player = $Player

var torch_collected: bool = false
var room_lit: bool = false

func _ready():
	# Start dark
	modulate.a = 0.3
	
	# Initial dialogue
	if dialogue_system:
		dialogue_system.queue_dialogue("Winter", "Where am I? Why is it so dark? I better find some light.")
	
	spawn_items()

func spawn_items():
	var item_scene = preload("res://scenes/ItemPickup.tscn")
	
	# Torch (main item needed to light room)
	var torch = item_scene.instantiate()
	torch.position = Vector2(400, 300)
	torch.item_id = Constants.ITEMS.TORCH
	add_child(torch)
	
	# Books
	var book1 = item_scene.instantiate()
	book1.position = Vector2(800, 200)
	book1.item_id = Constants.ITEMS.BOOK_1
	add_child(book1)
	
	# Other items
	var card = item_scene.instantiate()
	card.position = Vector2(600, 400)
	card.item_id = Constants.ITEMS.PLAYING_CARD
	add_child(card)
	
	var vase = item_scene.instantiate()
	vase.position = Vector2(1000, 500)
	vase.item_id = Constants.ITEMS.VASE
	add_child(vase)
	
	var glasses = item_scene.instantiate()
	glasses.position = Vector2(300, 350)
	glasses.item_id = Constants.ITEMS.GLASSES
	add_child(glasses)
	
	var mug = item_scene.instantiate()
	mug.position = Vector2(700, 450)
	mug.item_id = Constants.ITEMS.MUG
	add_child(mug)
	
	# Coffee beans (15 scattered)
	for i in range(15):
		var bean = item_scene.instantiate()
		bean.position = Vector2(
			randi() % 1920,
			randi() % 1080
		)
		bean.item_id = Constants.ITEMS.COFFEE_BEAN
		add_child(bean)

func _process(_delta):
	# Check if torch has been collected to light up room
	if not room_lit and game_manager.inventory_items.has(Constants.ITEMS.TORCH):
		light_up_room()

func light_up_room():
	room_lit = true
	var tween = create_tween()
	tween.tween_property(self, "modulate:a", 1.0, 1.0)
	if dialogue_system:
		dialogue_system.queue_dialogue("Winter", "Ah! A torch! That should help.")
