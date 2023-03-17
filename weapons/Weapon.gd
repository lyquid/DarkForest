# Base class for all weapons.
extends Node2D

class_name Weapon

var cooldown: float
var damage: int
var direction: Vector2
var manager: WeaponsManager
var speed: float
var weapon_name: String


func _ready():
	manager = get_parent()
