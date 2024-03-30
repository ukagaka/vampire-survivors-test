extends PanelContainer

signal selected

@onready var name_label = %NameLabel
@onready var description_label: Label = %DescriptionLabel


func _ready():
	gui_input.connect(on_gui_input)

func set_ability_upgrade(upgrade: AbilityUpgrade):
	print(upgrade.name)
	name_label.text = upgrade.name
	description_label.text = upgrade.description
	
func on_gui_input(event:InputEvent):
	if event.is_action_pressed("left_click"):
		selected.emit()
