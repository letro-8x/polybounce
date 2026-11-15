extends CharacterBody2D


const SPEED = 800.0
var cont = false
var direc_x
var direc_y
var initial = position
var cleared = false
var escaped = false
var started = false

func _physics_process(delta: float) -> void:
	
	if Input.is_action_just_pressed("restart"):
		position = initial
		velocity = Vector2(0,0)
		cleared = false
		escaped = false
		started = false
		cont = false
	
	if Input.is_action_just_pressed("left_click"):
		initial = position
		cont = true
		started = true
		
		var mouse_pos = get_global_mouse_position()
	
		var ball_pos = position
		
		direc_x = -(ball_pos.x-mouse_pos.x)
		direc_y = -(ball_pos.y-mouse_pos.y)
		var hypo = sqrt((direc_x)**2+(direc_y)**2)
		
		direc_x = direc_x/hypo
		direc_y = direc_y/hypo
	
	if cont:
		velocity=Vector2(direc_x,direc_y).normalized()*SPEED
		cont = false
	if not cleared:
		var collision = move_and_collide(velocity*delta)
		if collision:
			velocity = velocity.bounce(collision.get_normal())
	if started:
		var distance = (initial.x-position.x)**2+(initial.y-position.y)**2
		if distance<100:
			if escaped == true:
				cleared = true
		else:
			escaped = true
		print(escaped)
		print(cleared)
		print(distance)
	
