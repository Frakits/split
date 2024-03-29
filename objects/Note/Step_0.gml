/// @description Input
// You can write your code in this editor
windowSize = 80;
audioPos = audio_sound_get_track_position(song)*1000;
if (!audio_is_paused(song)) {
	for (var strum=0; strum<array_length(chart.strumLines); strum++)
		for (var i=0; i<array_length(chart.strumLines[strum].controls); i++)
			if (keyboard_check_pressed(chart.strumLines[strum].controls[i]) && !chart.strumLines[strum].opponent) checkInput(i,strum);
}

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
opponentTime = 0;
for (var i=0; i<array_length(chart.strumLines); i++) {
	if (array_length(chart.strumLines[i].notes) != 0) {
		var timeing = chart.strumLines[i].notes[0].time - audioPos;
		if (timeing <= -windowSize && !chart.strumLines[i].opponent){
			array_delete(chart.strumLines[i].notes, 0, 1);
			chart.strumLines[i].combo = 0;
		}
		if (chart.strumLines[i].opponent) {
			if (opponentTime + 5000 < current_time) for (var j=0; j<array_length(chart.strumLines[i].controls); j++) keyboard_key_release(chart.strumLines[i].controls[j]);
			for (var j=0; j<array_length(chart.strumLines[i].notes); j++) {
				if (chart.strumLines[i].notes[j].time - audioPos <= 10){
					for (var k=0; k<array_length(chart.strumLines[i].controls); k++) keyboard_key_release(chart.strumLines[i].controls[k]);
					keyboard_key_press(chart.strumLines[i].controls[chart.strumLines[i].notes[j].id]);
					opponentTime = current_time;
					array_delete(chart.strumLines[i].notes, j, 1);
					chart.strumLines[i].combo++;
				} 
			}
		}
	}
}

function initiateInputSelect(strumline, strumer) {
	inputSelecting = true;
	curStrumLine = strumline;
	curStrum = strumer;
}

if (inputSelecting) {
	if (keyboard_check_pressed(vk_anykey)) {
		inputSelecting = false;
		chart.strumLines[curStrumLine].controls[curStrum] = keyboard_lastkey;
	}
}