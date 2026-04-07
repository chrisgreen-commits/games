# GameManager.gd

# Central game state manager that tracks lives, coffee beans, inventory, mug collection status, and room progression.

# Includes signals for state changes and methods to manage items, beans, lives, and room transitions.

class_name GameManager

signal lives_changed(lives)
signal beans_changed(coffee_beans)
signal inventory_updated(inventory)
signal mug_collection_updated(mug_collection)
signal room_progression_updated(room_progression)

var lives: int = 3
var coffee_beans: int = 0
var inventory: Array = []
var mug_collection: Array = []
var room_progression: int = 0

func _ready():
    # Initialize the game manager
    update_signals()

func update_signals():
    emit_signal("lives_changed", lives)
    emit_signal("beans_changed", coffee_beans)
    emit_signal("inventory_updated", inventory)
    emit_signal("mug_collection_updated", mug_collection)
    emit_signal("room_progression_updated", room_progression)

func add_lives(amount: int):
    lives += amount
    update_signals()

func add_coffee_beans(amount: int):
    coffee_beans += amount
    update_signals()

func add_item(item):
    inventory.append(item)
    update_signals()

func collect_mug(mug):
    mug_collection.append(mug)
    update_signals()

func progress_room():
    room_progression += 1
    update_signals()