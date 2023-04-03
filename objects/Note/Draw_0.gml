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
	for (var j=0; j<4; j++) {
		var strumOffset = (room_width / array_length(chart.strumLines)) / 2 + (room_width / array_length(chart.strumLines) * i) - 150 + (100 * j);
		var keybinders = [keyboard_check(ord("A")), keyboard_check(ord("S")), keyboard_check(vk_up), keyboard_check(vk_right)];
		draw_sprite_ext(Note, Note, strumOffset, chart.strumLines[i].downScroll ? room_height - 100 : 100, 0.6,0.6,rots[j], keybinders[j] && i == 1 ? c_gray : c_white, 1);
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