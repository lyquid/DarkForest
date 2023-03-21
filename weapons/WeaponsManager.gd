extends Node2D

class_name WeaponsManager

@onready var main := get_tree().root.get_node("Main")
@onready var player := get_tree().root.get_node("Main/Player")

var laser_cannon_scene := preload("res://weapons/laser cannon/LaserCannon.tscn")
var railgun_scene := preload("res://weapons/railgun/Railgun.tscn")
var torpedo_launcher_scene := preload("res://weapons/torpedo launcher/TorpedoLauncher.tscn")


func _ready():
	var laser_cannon := laser_cannon_scene.instantiate()
	add_child(laser_cannon)
	var railgun := railgun_scene.instantiate()
	add_child(railgun)
	var torpedo_launcher := torpedo_launcher_scene.instantiate()
	add_child(torpedo_launcher)
