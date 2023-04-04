/// @description Render notes on screen
// You can write your code in this editor
for (var i=0; i<array_length(chart.strumLines); i++) {
	var texter = ["opponent", "player", "missing player"]
	draw_set_halign(fa_center);
	draw_set_valign(fa_center);
	draw_text((room_width / array_length(chart.strumLines)) / 2 + (room_width / array_length(chart.strumLines) * i), 10, texter[i]);
	draw_text_ext_transformed((room_width / array_length(chart.strumLines)) / 2 + (room_width / array_length(chart.strumLines) * i), 200, string(chart.strumLines[i].combo),
	10, room_height, 1.5, 1.5, 0);
	var rots = [90,180,0,-90];
	var ything = chart.strumLines[i].downScroll ? room_height - 100 : 100;
	for (var j=0; j<4; j++) {
		var strumOffset = (room_width / array_length(chart.strumLines)) / 2 + (room_width / array_length(chart.strumLines) * i) - 150 + (100 * j);
		var keybinders = chart.strumLines[i].controls;
		draw_sprite_ext(Note, Note, strumOffset, ything, 0.6,0.6,rots[j], keyboard_check(keybinders[j]) ? c_gray : c_white, 1);
		
		if(audio_is_paused(song) && mouse_check_button_pressed(mb_left) && strumOffset - 80<mouse_x && mouse_x<strumOffset+80
																		 && ything - 80<mouse_y && mouse_y<ything+80) initiateInputSelect(i, j);
		if (inputSelecting && curStrumLine == i && curStrum == j) draw_text(strumOffset, ything, round(abs(sin(current_time))) == 1 ? "-----" : " ");
		else draw_text(strumOffset, ything, keytostring(chart.strumLines[i].controls[j]));
	}
	if (audio_is_paused(song)) {
		var xThinger = (room_width / array_length(chart.strumLines)) / 2 + (room_width / array_length(chart.strumLines) * i);
		if (mouse_check_button_pressed(mb_left) && xThinger-150<mouse_x 
		&& mouse_x<xThinger+150 
		&& (!chart.strumLines[i].downScroll ? room_height - 200 : 100)<mouse_y 
		&& mouse_y<(!chart.strumLines[i].downScroll ? room_height - 100 : 200)) chart.strumLines[i].opponent = !chart.strumLines[i].opponent;
		draw_set_colour(c_gray);
		draw_button(xThinger-150, !chart.strumLines[i].downScroll ? room_height - 100 : 100,
						xThinger+150, !chart.strumLines[i].downScroll ? room_height - 200 : 200, chart.strumLines[i].opponent);
		draw_set_colour(c_white);
		draw_text(xThinger, !chart.strumLines[i].downScroll ? room_height - 150 : 150, "Opponent Mode: " + (chart.strumLines[i].opponent ? "On" : "Off"));
	}
	var curNotes = chart.strumLines[i].notes;
	for (var j=0; j<array_length(curNotes); j++) {
		var noteOffset = (room_width / array_length(chart.strumLines)) / 2 + (room_width / array_length(chart.strumLines) * i) - 150 + (100 * curNotes[j].id);
		var d = chart.strumLines[i].downScroll;
		var speedy = (d ? (audio_sound_get_track_position(song)*1000)-curNotes[j].time : curNotes[j].time-(audio_sound_get_track_position(song)*1000)) * (chart.scrollSpeed - 1) + (d ? room_height - 100 : 100);
		if (speedy < room_height)
			draw_sprite_ext(Note, Note, noteOffset, speedy,0.6,0.6,rots[curNotes[j].id],c_lime,1);
	}
}
if (audio_is_paused(song)) draw_text_ext_transformed(room_width / 2, room_height / 2, "PAUSED!! press space to unpause", 5, room_width, 4, 4, 0);