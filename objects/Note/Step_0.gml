/// @description Input
// You can write your code in this editor
windowSize = 80;
audioPos = audio_sound_get_track_position(song)*1000;

if (keyboard_check(ord("A"))) checkInput(0,1);
if (keyboard_check(ord("S"))) checkInput(1,1);
if (keyboard_check(vk_up)) checkInput(2,1);
if (keyboard_check(vk_right)) checkInput(3,1);

if (keyboard_check_pressed(ord("Q"))) chart.strumLines[0].downScroll = !chart.strumLines[0].downScroll;
if (keyboard_check_pressed(ord("W"))) chart.strumLines[1].downScroll = !chart.strumLines[1].downScroll;
if (keyboard_check_pressed(ord("E"))) chart.strumLines[2].downScroll = !chart.strumLines[2].downScroll;

if (keyboard_check_pressed(vk_space)) {
	if (audio_is_paused(song)) audio_resume_all();
	else audio_pause_all();
}
function checkInput(inId, strum) {
	for (var i=0; i<array_length(chart.strumLines[strum].notes); i++) {
		var curNote = chart.strumLines[strum].notes[i];
		var hitNote = false;
		if (!hitNote && inId == curNote.id && -windowSize <= curNote.time - audioPos && curNote.time - audioPos <= windowSize) {
			array_delete(chart.strumLines[strum].notes, i, 1);
			hitNote = true;
			chart.strumLines[strum].combo++;
		}
	}
}
for (var i=0; i<array_length(chart.strumLines); i++) {
	if (array_length(chart.strumLines[i].notes) != 0) {
		var timeing = chart.strumLines[i].notes[0].time - audioPos;
		if (timeing <= -windowSize && !chart.strumLines[i].opponent){
			array_delete(chart.strumLines[i].notes, 0, 1);
			chart.strumLines[i].combo = 0;
		}
		if (chart.strumLines[i].opponent) {
			for (var j=0; j<clamp(10,0,array_length(chart.strumLines[i].notes)); j++) {
				if (chart.strumLines[i].notes[j].time - audioPos <= 10){
					array_delete(chart.strumLines[i].notes, j, 1);
					chart.strumLines[i].combo++;
				} 
			}
		}
	}
}