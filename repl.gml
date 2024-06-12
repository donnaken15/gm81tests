globalvar init;
if init != true {
	init = true
	globalvar text, text_a1, killme, close_event, cols, rows;
	close_event = 'killme = true;'
	killme = false;
	cols = 80;
	rows = 20;
	// implement resizing because im stupid crazy
	charcount = $60;
	text = sprite_add('mig68000_8x16.png', charcount, true, false, 0, 0);
	text_a1 = font_add_sprite(text, ord(' '), false, 0);
	room_speed = 100;
	repl = object_add();
	object_event_add(repl, ev_other, ev_close_button, 'execute_string(close_event);');
	object_event_add(repl, ev_destroy, 0, 'execute_string(close_event);');
	object_event_add(repl, ev_create, 0, '
		_current_line = "";
		_cursor = 0;
		_sellength = 1;
		_overwrite = 0;
		var _histfile;
		_histidx = 0;
		_histcnt = 0;
		var _evalhist;
	');
	object_event_add(repl, ev_draw, 0, 'execute_file("repl_loop.gml");');
	//room_set_background_color(repl, c_black, true);
	room_set_width(repl, cols * sprite_get_width(text));
	room_set_height(repl, rows * sprite_get_height(text));
	room_set_persistent(room, true);
	room_restart();
	window_set_showborder(true);
	//window_set_region_scale(2,true);
	//error_last
	//error_occurred
} else { // hack >:(
	instance_create(0, 0, repl);
	room_caption = "gmlrun REPL - "+environment_get_variable('username')+"#";
}

