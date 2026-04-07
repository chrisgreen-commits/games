extends Node

class_name DialogueSystem

signal dialogue_started(character, text)
signal dialogue_finished

var dialogue_queue: Array = []
var is_playing: bool = false

func queue_dialogue(character: String, text: String, duration: float = 3.0) -> void:
	dialogue_queue.append({
		"character": character,
		"text": text,
		"duration": duration
	})
	if not is_playing:
		_play_next()

func _play_next() -> void:
	if dialogue_queue.is_empty():
		is_playing = false
		dialogue_finished.emit()
		return
	
	is_playing = true
	var dialogue = dialogue_queue.pop_front()
	dialogue_started.emit(dialogue.character, dialogue.text)
	print(dialogue.character + ": " + dialogue.text)
	
	await get_tree().create_timer(dialogue.duration).timeout
	_play_next()

func clear_queue() -> void:
	dialogue_queue.clear()
	is_playing = false
