extends Resource
class_name Item


@export var name: String
@export var texture: Texture2D
@export_enum("Commun", "Uncommun", "Rare", "Epic", "Legendary") var rarity: int
@export_multiline var description: String
@export var stack_size: int = 16
@export var price: int
