extends CPUParticles2D



func _on_FreezeBlood_timeout():
	set_process(false) # process delta = false
	set_physics_process(false)
	set_process_input(false)
	set_process_internal(false)
	set_process_unhandled_input(false)
	set_process_unhandled_key_input(false)
	
