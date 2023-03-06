extends Node2D

class_name WeaponsManager

var laser_cannon_scene := preload("res://weapons/laser cannon/LaserCannon.tscn")


func _ready():
	var laser_cannon := laser_cannon_scene.instantiate()
	add_child(laser_cannon)
