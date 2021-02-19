extends Node2D

class_name BaseLevel

func serialize() -> Dictionary:
	var save_nodes := get_tree().get_nodes_in_group("Persist")
	var node_data := []
	var player_data: Dictionary
	for node in save_nodes:
		if node is Player:
			player_data = node.serialize()
		else:
			node_data.append(node.serialize())
	var data := {
		"levelscene" : get_filename(),
		"objects" : node_data,
		"player" : player_data
	}
	return data

func load_data(game_data: Dictionary):
	var save_nodes := get_tree().get_nodes_in_group("Persist")
	for node in save_nodes:
		if node is Player:
			node.deserialize(game_data["player"])
		else:
			node.queue_free()
	var scenes = Dictionary()
	var objects = game_data["objects"]
	for object in objects:
		var scene_path: String = object["filename"]
		if not scenes.has(scene_path):
			scenes[scene_path] = load(scene_path)
		var instance: Node = scenes[object["filename"]].instance()
		instance.deserialize(object)
		$Objects.add_child(instance)

func _on_Player_dying():
	var timer = Timer.new()
	timer.wait_time = 3.5
	add_child(timer)
	timer.start()
	yield(timer, "timeout")
	get_tree().change_scene("res://ui/GameOver.tscn")
