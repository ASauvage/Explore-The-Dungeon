extends Resource
class_name Item


@export var name: String
@export_enum("Equipement", "Weapon", "Consomable", "Material", "Valuable") var type: String
@export_enum("Commun", "Uncommun", "Rare", "Epic", "Legendary") var rarity: int
@export var texture: Texture2D
@export_multiline var description: String
@export var stack_size: int
@export var effect: String
