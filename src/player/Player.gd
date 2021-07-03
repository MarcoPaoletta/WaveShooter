extends Sprite

var speed = 150
var velocity = Vector2()
var bullet = preload("res://src/bullet/Bullet.tscn")
var can_shoot = true
var is_dead = false
var reload_speed = 0.1 
var default_reload_speed = reload_speed
var power_up_reset = []
var damage = 1
var default_damage = damage

func _ready():
	OS.center_window()
	Global.player = self # this is the player
	
func _exit_tree():
	Global.player = null # when it gets destroyed

func _process(delta):
	# if we prees both k, it will stop
	velocity.x = int(Input.is_action_pressed("right")) - int(Input.is_action_pressed("left")) # by default is a boolean 
	velocity.y = int(Input.is_action_pressed("down")) - int(Input.is_action_pressed("up"))
	
	velocity = velocity.normalized() # normalize velocity
	global_position.x = clamp(global_position.x, 0, 640)
	global_position.y = clamp(global_position.y, 0, 360)
	
	if is_dead == false:
		global_position += speed * velocity * delta

	if Input.is_action_pressed("shoot") and Global.node_creation_parent != null and can_shoot and is_dead == false:
		var bullet_instance = Global.instance_node(bullet, global_position, Global.node_creation_parent)
		bullet_instance.damage = damage
		$ReloadSpeed.start()
		can_shoot = false

func _on_ReloadSpeed_timeout():
	can_shoot = true
	$ReloadSpeed.wait_time = reload_speed


func _on_Hitbox_area_entered(area):
	if area.is_in_group("Enemy"):
		is_dead = true
		visible = false
		Global.save_game()
		yield(get_tree().create_timer(1), "timeout")
		get_tree().reload_current_scene()

func _on_PowerUpCooldown_timeout():
	if power_up_reset.find("Power_up_reload") != null:
		reload_speed = default_reload_speed
		power_up_reset.erase("Power_up_reload")
	elif power_up_reset.find("Power_up_damage") != null:
		damage = default_damage
		power_up_reset.erase("Power_up_damage")
