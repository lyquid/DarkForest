extends Node2D

class_name WeaponsManager

var laser_cannon_scene := preload("res://weapons/laser cannon/LaserCannon.tscn")
var railgun_scene := preload("res://weapons/railgun/Railgun.tscn")


func _ready():
	var laser_cannon := laser_cannon_scene.instantiate()
	add_child(laser_cannon)
	var railgun := railgun_scene.instantiate()
	add_child(railgun)
