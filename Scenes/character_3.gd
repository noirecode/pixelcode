extends CharacterBody2D

const SPEED = 600.0
const JUMP_VELOCITY = -250.0
var detected_area = null

@onready var sprite_1 = $sprite1
@onready var ray_cast_2d_down = $RayCast2D_DOWN
@onready var ray_cast_2d_right = $RayCast2D_RIGHT
@onready var ray_cast_2d_up = $RayCast2D_UP
@onready var ray_cast_2d_left = $RayCast2D_LEFT
@onready var ray_cast_2d_diag_r = $RayCast2D_DIAG_R
@onready var ray_cast_2d_diag_l = $RayCast2D_DIAG_L
@onready var ray_cast_2d_diag_rd = $RayCast2D_DIAG_RD
@onready var ray_cast_2d_diag_ld = $RayCast2D_DIAG_LD
@onready var sfx_jump = $sfx_jump
@onready var sfx_use = $sfx_use
@onready var sfx_pickup = $sfx_pickup

var level_scene = ''

func _ready():
	level_scene = get_parent().get_parent()
# Get the gravity from the project settings to be synced with RigidBody nodes.
var gravity = ProjectSettings.get_setting("physics/2d/default_gravity")

func _physics_process(delta):
	if not is_on_floor():
		velocity.y += (gravity*2) * delta
	move_and_slide()

func raycast_update():
	ray_cast_2d_down.force_raycast_update()
	ray_cast_2d_left.force_raycast_update()
	ray_cast_2d_right.force_raycast_update()
	ray_cast_2d_up.force_raycast_update()
	ray_cast_2d_diag_l.force_raycast_update()
	ray_cast_2d_diag_r.force_raycast_update()
	ray_cast_2d_diag_rd.force_raycast_update()
	ray_cast_2d_diag_ld.force_raycast_update()
	
func parse_command(instructions_list):
	
	while !is_on_floor():
		await get_tree().create_timer(0.1).timeout
	sprite_1.play("walk")
	prints("in command parse, this is the list: ", instructions_list)
	for command in instructions_list:
		raycast_update()
		match command:
			"moverDer()":
				if !ray_cast_2d_right.is_colliding():
					flip(false)
					await mover(Vector2.RIGHT,1,0.35)
			"moverIzq()":
				if !ray_cast_2d_left.is_colliding():
					flip(true)
					await mover(Vector2.LEFT,1,0.35)
			"saltar(izq)":
				flip(true)
				await saltar("diag_left")
			"saltar(der)":
				flip(false)
				await saltar("diag_right")
			"saltar(arriba)":
				await saltar("up")
			"saltar(abajo)":
				await saltar("down")
			"tomarLlave()":
				await pickUp()
			"utilizarLlave()":
				await utilizarLlave()
		
		await get_tree().create_timer(0.2).timeout
		while not is_on_floor():
			await get_tree().create_timer(0.2).timeout
	sprite_1.stop()
	sprite_1.play("default")

func pickUp():
	if level_scene.inside_key:
		#get_parent().inside_key = false
		sfx_pickup.play()
		detected_area.visible = false
		level_scene.keys[level_scene.curr_key] = true
		#if get_parent().multiple_keys:
			#pass
		#else: get_parent().has_key = true
		detected_area = null

func utilizarLlave():
	var key = level_scene.find_key()
	if key: 
		if level_scene.inside_keybox and level_scene.keys[key]:
			if detected_area:
				sfx_use.play()
				detected_area.visible = false
				print("key used!")
				level_scene.keys[key] = false
				#get_parent().box_solved = true
				
				level_scene.boxes[level_scene.curr_box] = true
				level_scene.all_boxes_solved()
	else: print("no key in hand.")

func get_area(area):
	detected_area = area

func flip(flag):
	sprite_1.flip_h = flag

func saltar(direction=null):
	sprite_1.play("walk")
	sfx_jump.play()
	var target: Vector2
	while !is_on_floor():
		await get_tree().create_timer(0.1).timeout
	var ray_diag_up
	var ray_col
	if direction == "diag_right" or direction == "diag_left":
		if !ray_cast_2d_up.is_colliding():
			
			match direction:
				"diag_right":
					ray_diag_up = ray_cast_2d_diag_r
					ray_col = ray_cast_2d_right
					target = Vector2(1,1)
				"diag_left":
					ray_diag_up = ray_cast_2d_diag_l
					ray_col = ray_cast_2d_left
					target = Vector2(-1,1)
			if !ray_diag_up.is_colliding() and !ray_col.is_colliding():
				await mover(target*Vector2(0.5,-0.5),1, 0.15)
				await mover(target*Vector2(0.5,0.5),1, 0.15)
			elif !ray_diag_up.is_colliding() and ray_col.is_colliding():
				await mover(target*Vector2(0.15,-0.5),1, 0.1)
				await mover(target*Vector2(0.15,-0.5),1, 0.05)
				await mover(target*Vector2(0.20,-0.5),1, 0.05)
				await mover(target*Vector2(0.25,0.25),1, 0.08)
				await mover(target*Vector2(0.25,0.25),1,0.08)
			else: 
				await mover(Vector2.UP,1, 0.1)

	elif direction == "down":
		await mover(Vector2.DOWN,0.1,0.1)
	else:
		if !ray_cast_2d_up.is_colliding():
			await mover(Vector2.UP,1, 0.1)
	while !is_on_floor():
		await get_tree().create_timer(0.1).timeout

func mover(direction: Vector2, distance, time):
	raycast_update()
	var tween = get_tree().create_tween()
	var target_position = position + direction * (global.TILE_SIZE * distance)
	tween.tween_property(self, "position", target_position, time)
	await tween.finished
	position = target_position

