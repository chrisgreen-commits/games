extends Node

class_name InventoryManager

signal inventory_changed
signal active_item_changed(item_id)

var inventory: Dictionary = {}
var active_item: int = -1

func add_item(item_id: int) -> void:
	if item_id not in inventory:
		inventory[item_id] = 0
	inventory[item_id] += 1
	inventory_changed.emit()

func remove_item(item_id: int) -> bool:
	if item_id in inventory and inventory[item_id] > 0:
		inventory[item_id] -= 1
		if inventory[item_id] == 0:
			inventory.erase(item_id)
		if active_item == item_id:
			active_item = -1
			active_item_changed.emit(-1)
		inventory_changed.emit()
		return true
	return false

func equip_item(item_id: int) -> bool:
	if item_id in inventory and inventory[item_id] > 0:
		active_item = item_id
		active_item_changed.emit(item_id)
		return true
	return false

func unequip_item() -> void:
	active_item = -1
	active_item_changed.emit(-1)

func has_item(item_id: int) -> bool:
	return item_id in inventory and inventory[item_id] > 0

func get_active_item() -> int:
	return active_item

func get_all_items() -> Dictionary:
	return inventory.duplicate()
