extends KinematicBody2D

# Player properties
var speed = 200
var jump_force = -600
var gravity = 1200
var is_jumping = false
var velocity = Vector2()

# AnimationPlayer Node
onready var animation_player = $AnimationPlayer

# Inventory state
var inventory_open = false

func _physics_process(delta):
    # Handle movement
    var direction = Vector2.ZERO
    if Input.is_action_pressed('ui_right'): direction.x += 1
    if Input.is_action_pressed('ui_left'): direction.x -= 1
    if Input.is_action_pressed('ui_down'): direction.y += 1
    if Input.is_action_pressed('ui_up'): direction.y -= 1

    # Normalize direction
    direction = direction.normalized()

    # Update velocity based on direction
    velocity.x = direction.x * speed
    if is_jumping:
        velocity.y += gravity * delta
    else:
        velocity.y = 0

    # Jumping logic
    if Input.is_action_just_pressed('jump') and not is_jumping:
        is_jumping = true
        velocity.y = jump_force
        animation_player.play("jump")

    move_and_slide(velocity)

    # Play animations based on movement
    if direction != Vector2.ZERO:
        animation_player.play("run")
    else:
        animation_player.play("idle")

    # Check for collisions and interact
    if is_on_floor():
        is_jumping = false

    if Input.is_action_just_pressed('interact'):
        interact_with_nearby_objects()

    # Inventory toggle
    if Input.is_action_just_pressed('toggle_inventory'):
        inventory_open = !inventory_open
        animation_player.play(inventory_open ? "inventory_open" : "inventory_close")

    # Special actions
    if Input.is_action_just_pressed('special_action'):
        perform_special_action()

func interact_with_nearby_objects():
    # Logic for interacting with nearby objects
    pass

func perform_special_action():
    # Logic for special actions based on context
    pass