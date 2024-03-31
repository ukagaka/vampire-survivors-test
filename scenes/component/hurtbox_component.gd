extends Area2D

class_name HurtboxCompponent

signal hit

@export var health_component: Node

var floating_text_scene = preload("res://scenes/ui/floating_text.tscn")

func _ready():
	area_entered.connect(on_area_entered)
	
func on_area_entered(other_area: Area2D):
	if not other_area is HitboxComponent:
		return 
	
	if health_component == null:
		return
		
	var hitbox_component = other_area as HitboxComponent
	health_component.damage(hitbox_component.damage)
	
	#加载伤害 UI 组件
	var floating_text = floating_text_scene.instantiate() as Node2D
	get_tree().get_first_node_in_group("foreground_layer").add_child(floating_text)
	
	floating_text.global_position = global_position + (Vector2.UP * 16)
	
	var format_string = "%0.1f"
	if round(hitbox_component.damage) == hitbox_component.damage:
		format_string = "%0.0f"
	floating_text.start(format_string %hitbox_component.damage)
	
	hit.emit()
