extends Node

var squads: Dictionary[String, Array]


func _init() -> void:
	var json_file = FileAccess.open("res://assets/json/squads.json", FileAccess.READ)
	if json_file == null: return
	var json_text = json_file.get_as_text() 
	var json = JSON.new()
	if json.parse(json_text) != OK: return
	for team in json.data:
		var country_name := team["country"] as String
		var players := team["players"] as Array
		if not squads.has(country_name):
			squads.set(country_name, [])
		for palyer in players:
			var player_resource = PlayerResource.new({
				"full_name": palyer["name"] as String, 
				"skin_color": palyer["skin"] as Player.SkinColor, 
				"role": palyer["role"] as Player.Role, 
				"speed": palyer["speed"] as float, 
				"power": palyer["power"] as float
			})
			squads.get(country_name).append(player_resource)
	json_file.close()


func get_squad(country: String) -> Array:
	if squads.has(country): return squads[country]
	return []
