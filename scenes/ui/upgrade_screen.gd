extends CanvasLayer

signal upgrade_selected(upgrade: AbilityUpgrade)

@export var upgrade_card_scene: PackedScene
@onready var card_container: HBoxContainer = $%CardContainer

func _ready():
	get_tree().paused = true

func set_ability_upgrades(upgrades: Array[AbilityUpgrade]):
	for upgrade in upgrades:
		var card_instance = upgrade_card_scene.instantiate()
		card_container.add_child(card_instance)
		card_instance.set_ability_upgrade(upgrade)
		print("ewrw000")
		card_instance.selected.connect(on_upgrade_selected.bind(upgrade))

func on_upgrade_selected(upgrade: AbilityUpgrade):
	print("ewrw111")
	upgrade_selected.emit(upgrade)
	get_tree().paused = false
	queue_free()
