window_set_visible(false);
obj = object_add();
object_event_add(obj, ev_create, 0, 'alarm[0] = 1;');
object_event_add(obj, ev_alarm, 0, '
external_call(external_define(working_directory+"\console.dll","initConsole",dll_cdecl,ty_real,1,ty_real),1|2|4);
printf = external_define(working_directory+"\console.dll","print",dll_cdecl,ty_real,1,ty_string);
alarm[1] = 5;
test = 0;
');
object_event_add(obj, ev_alarm, 1, '
external_call(printf,"TEST "+string(test)+chr($A));
alarm[1] = 5;
test += 1;
');
instance_create(0,0,obj);
