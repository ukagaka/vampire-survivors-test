extends Node

#生成半径，要超过屏幕大小，这样才显的怪是从窗口外面生成的，而不是中途生成
const SPAWN_PADIUS = 370

@export var basic_enemy_scene: PackedScene
@export var wizard_enemy_scene: PackedScene
@export var arena_time_manager: Node

@onready var timer = $Timer

var base_spawn_time = 0
var enemy_table = WeightedTable.new()

# Called when the node enters the scene tree for the first time.
func _ready():
	enemy_table.add_item(basic_enemy_scene, 10)
	base_spawn_time = timer.wait_time
	timer.timeout.connect(on_timer_timeout)
	arena_time_manager.arena_difficulty_increased.connect(arena_difficulty_increased)
	
func get_spawn_position():
	var player = get_tree().get_first_node_in_group('player') as Node2D
	if player == null: 
		return Vector2.ZERO
	
	var spawn_position = Vector2.ZERO
	var random_direction = Vector2.RIGHT.rotated(randf_range(0, TAU))
	
	#找出墙体位置，如果找到墙体，碰撞说明该位置不能移动，需要旋转 90度再次看看是否能够生成
	#注意，因为竞技场大小与生成的怪物（SPAWN_PADIUS 生成半径超过了竞技场），所以基本都是有碰撞的，
	#需要把竞技场调大，只要保证 SPAWN_PADIUS 半径大小，角色站中间，怪是从四面八方出现说明竞技场大小合适
	
	for i in 4:
	
		#随机位置：用户位置+随机位置+距离
		spawn_position = player.global_position + (random_direction * SPAWN_PADIUS)

		#用户的位置作为起点，新怪物的位置为终点，根据他们的图层，检查他们之间是否有碰撞物
		var query_paramaters = PhysicsRayQueryParameters2D.create(player.global_position, spawn_position, 1)
		
		#然后在实际进行相交再调用，查看是否有地形相交
		var result = get_tree().root.world_2d.direct_space_state.intersect_ray(query_paramaters)
		
		if result.is_empty():
			break
		else:
			random_direction = random_direction.rotated(deg_to_rad(90))
			
	return spawn_position
	

func on_timer_timeout():
	
	timer.start()
	
	var player = get_tree().get_first_node_in_group("player") as Node2D
	if player == null: 
		return
		
	var enemy_scene = enemy_table.pick_item()
	var enemy = enemy_scene.instantiate() as Node2D
	 
	var entities_layer = get_tree().get_first_node_in_group('entities_layer')
	entities_layer.add_child(enemy)
	
	enemy.global_position = get_spawn_position()

func arena_difficulty_increased(arena_difficulty: int):
	var time_off = (0.1/12) * arena_difficulty
	time_off = min(time_off, 0.7)
	timer.wait_time = base_spawn_time - time_off
	
	if arena_difficulty == 6:
		enemy_table.add_item(wizard_enemy_scene, 20)
