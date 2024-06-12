var i, _key, _shift, _line_draw, blink_cursor, _retval;
_shift = keyboard_check_direct(vk_shift);
_test = keyboard_lastkey;
for (i = 0; i < 10; i += 1)
{
	io_handle(); // got the getkeystate thing to work like cmd using this :p
	_key = keyboard_key;
	while _key != vk_nokey
	{
		switch (_key)
		{
			//case vk_enter:
			//	break;
			case vk_escape:
				execute_string(close_event);
				break;
			case vk_left:
				_cursor -= 1;
				break;
			case vk_right:
				_cursor += 1;
				break;
			case vk_up:
				if _histcnt < 1 break;
					_histidx = max(0, _histidx - 1);
					_current_line = _histfile[_histidx];
				break;
			case vk_down:
				if _histcnt < 1 break;
					_histidx = min(_histcnt - 1, _histidx + 1);
					_current_line = _histfile[_histidx];
				break;
			//case vk_tab:
			case vk_home:
			case vk_end:
			case vk_pageup:
			case vk_pagedown:
			case vk_pause:
			case vk_printscreen:
			case vk_f1:
			case vk_f2:
			case vk_f3:
			case vk_f4:
			case vk_f5:
			case vk_f6:
			case vk_f7:
			case vk_f8:
			case vk_f9:
			case vk_f10:
			case vk_f11:
			case vk_f12:
			//case vk_numpad0:
			//case vk_numpad1:
			//case vk_numpad2:
			//case vk_numpad3:
			//case vk_numpad4:
			//case vk_numpad5:
			//case vk_numpad6:
			//case vk_numpad7:
			//case vk_numpad8:
			//case vk_numpad9:
			case 144: // numlock
			//case vk_multiply:
			//case vk_divide:
			//case vk_add:
			//case vk_subtract:
			//case vk_decimal:
				break;
			case vk_insert:
				_overwrite = 1 - _overwrite;
				break;
			case vk_backspace:
				_cursor -= 1;
			case vk_delete:
				_current_line = string_delete(_current_line, _cursor+1, 1);
				break;
			case vk_control:
			case vk_alt:
			case vk_shift:
				break;
			default:
				if keyboard_check_pressed(vk_enter) && !_shift
				{
					_retval = string(execute_string(_current_line));
					if _current_line != ""
					{
						_histfile[_histcnt] = _current_line;
						_evalhist[_histcnt] = _retval;
						_histcnt += 1;
						_histidx = _histcnt;
						_histfile[_histcnt] = "";
					}
					_current_line = "";
					break;
				}
				if keyboard_check_pressed(_key)
				{
					var _chr;
					switch (_key)
					{
						case 219:
						case 220:
						case 221:
						case 222:
							_chr = string_copy("[{\|]}'"+'"',((_key-219)*2)+_shift+1,1);
							break;
						case 186:
						case 187:
						case 188:
						case 189:
						case 190:
						case 191:
						//numpad buttons
						case 106: // *
						case 107: // +
						case 109: // -
						case 110: // .
						case 111: // /
							switch (_key)
							{
								case 106:
									_key = 56;
									_shift = 1;
									break;
								case 107:
									_key = _key + 80;
									_shift = 1;
									break;
								case 109:
								case 110:
								case 111:
									_key = _key + 80;
									_shift = 0;
									break;
								default:
									break;
							}
							_chr = string_copy(";:=+,<-_.>/?`~",((_key-186)*2)+_shift+1,1);
							break;
						default:
							_chr = chr(_key);
							break;
					}
					if (!_shift)
					{
						_chr = string_lower(_chr);
						if _key >= 96 && _key <= 105 && keyboard_get_numlock() // numpad
							_chr = chr(_key - 48);
					}
					else
					{
						if _key >= ord('0') && _key <= ord('9')
							_chr = string_copy(")!@#$%^&*(",(_key-ord('0')+1), 1);
					}
					if _overwrite
					{
						_current_line = string_delete(_current_line, _cursor+1, 1);
					}
					_current_line = string_insert(_chr, _current_line, _cursor+1);
					_cursor += 1;
				}
				break;
		}
		_key = vk_nokey;
	}
	_cursor = max(0, min(string_length(_current_line), _cursor));
	io_clear();
}
if killme
	game_end()
draw_set_font(text_a1);
draw_set_color(c_white);
draw_set_halign(fa_left);
draw_set_valign(fa_top);
blink_cursor = round((current_time mod 200)/200);
_line_draw = _current_line;
if blink_cursor
	_line_draw = string_insert(string_copy(chr(127)+'_', 1+_overwrite, 1), string_delete(_line_draw, _cursor+1, 1), _cursor+1);
_line_draw = '>' + _line_draw;
for (i = _histcnt - 1; i >= 0 && i > _histcnt - ((rows-2) * 2); i -= 1)
{
	_line_draw = '>'+_histfile[i]+chr(10)+_evalhist[i]+chr(10)+_line_draw;
}

if string_count(chr(10), _line_draw)+string_count(chr(13), _line_draw) >= rows
{
	draw_set_valign(fa_bottom);
	line_y = room_height
}
else
{
	draw_set_valign(fa_top);
	line_y = 0
}
draw_text(0,line_y,
	string_replace_all(
		string_replace_all(
			_line_draw,
		'#','\#'),
	chr(9),'    '));

