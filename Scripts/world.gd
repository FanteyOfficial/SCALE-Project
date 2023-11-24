extends Node2D

var toothbrush_attack = preload("res://Scenes/toothbrush.tscn")
@onready var pesce = get_node("ErPesce")
@onready var player = get_node("Player")
@onready var area_attack = $"area_attack"
@onready var aoe_dur = $"aoe_duration"


func _on_area_attack_timeout(): #NB LE SPIKE SONO UNFAIR, PLS FIX
	area_attack.start(5)
	var tooth_spawn = get_node("SpawnPath/SpawnLocation")
	for i in range(10):
		var tooth = toothbrush_attack.instantiate()
		tooth_spawn.progress = player.position.x-20 + 100*i
		tooth.init(tooth_spawn.position)
		add_child(tooth)
	aoe_dur.start(1)
	#area_attack.set_wait_time(10)


func _on_aoe_duration_timeout():
	get_tree().call_group("aoe","kill")
