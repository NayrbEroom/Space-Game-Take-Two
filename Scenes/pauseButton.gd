extends Button


func button_pressed():
	$Root/time_keeper.advance_time(1)
	
