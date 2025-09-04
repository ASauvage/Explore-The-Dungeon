class_name Item
extends Resource


@export var name: String
@export_enum("Equipement", "Weapon", "Consomable", "Material", "Valuable") var type: String
@export_enum("Commun", "Uncommun", "Rare", "Epic", "Legendary") var rarity: int
@export var texture: Texture2D
@export var description: String
@export var stack_size: int
@export var effect: String
