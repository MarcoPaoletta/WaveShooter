extends Sprite

func _on_Hitbox_area_entered(area):
	if area.is_in_group("Player"):
		area.get_parent().reload_speed = 0.05
		area.get_parent().get_node("PowerUpCooldown").wait_time = 2
		area.get_parent().get_node("PowerUpCooldown").start()
		area.get_parent().power_up_reset.append("Power_up_reload")
		queue_free()
		
		
