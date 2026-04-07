extends Area2D

class_name ItemPickup

@export var item_id: int = 0
@onready var sprite = $Sprite2D

var player: Node2D = null

func _ready():
	area_entered.connect(_on_area_entered)
	area_exited.connect(_on_area_exited)
	update_sprite()

func update_sprite():
	var sprite_map = {
		Constants.ITEMS.TORCH: "res://assets/sprites/torch_item.png",
		Constants.ITEMS.PLAYING_CARD: "res://assets/sprites/playing_card.png",
		Constants.ITEMS.VASE: "res://assets/sprites/vase.png",
		Constants.ITEMS.BOOK_1: "res://assets/sprites/book.png",
		Constants.ITEMS.BOOK_2: "res://assets/sprites/book.png",
		Constants.ITEMS.BOOK_3: "res://assets/sprites/book.png",
		Constants.ITEMS.GLASSES: "res://assets/sprites/glasses.png",
		Constants.ITEMS.MUG: "res://assets/sprites/coffee_mug.png",
		Constants.ITEMS.COFFEE_BEAN: "res://assets/sprites/coffee_bean.png",
		Constants.ITEMS.FLIP_PHONE: "res://assets/sprites/flip_phone.png",
		Constants.ITEMS.CANDLESTICK: "res://assets/sprites/candlestick.png",
		Constants.ITEMS.NOTEPAD: "res://assets/sprites/notepad.png",
		Constants.ITEMS.WRIST_WATCH: "res://assets/sprites/wrist_watch.png",
		Constants.ITEMS.POOL_CUE: "res://assets/sprites/pool_cue.png",
		Constants.ITEMS.POOL_BALLS: "res://assets/sprites/pool_ball.png",
	}
	
	if item_id in sprite_map:
		sprite.texture = load(sprite_map[item_id])

func _on_area_entered(area):
	if area.is_in_group("player"):
		player = area
		if player.has_method("on_item_entered"):
			player.on_item_entered(self)

func _on_area_exited(area):
	if area.is_in_group("player"):
		if player and player.has_method("on_item_exited"):
			player.on_item_exited(self)
		player = null

func interact(player_ref: Node2D):
	var game_manager = get_node("/root/Main/GameManager")
	var dialogue_system = get_node("/root/Main/DialogueSystem")
	
	if item_id == Constants.ITEMS.COFFEE_BEAN:
		if not game_manager.has_mug:
			if dialogue_system:
				dialogue_system.queue_dialogue("Winter", "I'll need something to put my coffee in first.")
			return
		else:
			game_manager.add_coffee_beans(1)
	elif item_id == Constants.ITEMS.MUG:
		game_manager.has_mug = true
	else:
		game_manager.add_item(item_id)
	
	queue_free()
