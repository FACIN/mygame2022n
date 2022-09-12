extends KinematicBody2D

export (int) var speed = 200
export (float) var rotation_speed = 1.5

var velocity := Vector2.ZERO
var rotation_dir := 0

# Onready inicializa como se estivesse no callback _ready
onready var target = position

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.
	
func _input(event):
	if event.is_action_pressed("click"):
		target = get_global_mouse_position()

func get_8way_input():
	velocity = Vector2.ZERO
	velocity.x = Input.get_action_strength("right") - Input.get_action_strength("left")
	velocity.y = Input.get_action_strength("down") - Input.get_action_strength("up")	
	velocity = velocity.normalized() * speed
	#print(velocity)

func get_rotation_input():
	rotation_dir = 0
	velocity = Vector2.ZERO
	if Input.is_action_pressed("right"):
		rotation_dir += 1
	if Input.is_action_pressed("left"):
		rotation_dir -= 1
	if Input.is_action_pressed("down"):
		velocity = Vector2(-speed, 0).rotated(rotation)
	if Input.is_action_pressed("up"):
		velocity = Vector2(speed, 0).rotated(rotation)

func get_mouse_input():
	look_at(get_global_mouse_position())
	velocity = Vector2()
	if Input.is_action_pressed("down"):
		velocity = Vector2(-speed, 0).rotated(rotation)
	if Input.is_action_pressed("up"):
		velocity = Vector2(speed, 0).rotated(rotation)
		
func _physics_process(delta):
	#get_8way_input()
	
	# Rotation keyboard
	#get_rotation_input()
	#rotation += rotation_dir * rotation_speed * delta	
	
	# Rotate mouse
	#get_mouse_input()	
	
	# Point and click
	velocity = position.direction_to(target) * speed	
	# look_at(target)
	if position.distance_to(target) > 5:
		velocity = move_and_slide(velocity)