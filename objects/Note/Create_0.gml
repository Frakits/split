/// @description Insert description here
// You can write your code in this editor
chart = global.doubleKillChart;
for (var i=0; i<array_length(chart.strumLines); i++){ 
	chart.strumLines[i].downScroll = false;
	chart.strumLines[i].combo = 0;
}
song = audio_play_sound(tutorials,0,0);
voicing = audio_play_sound(voicers,0,0);
audio_pause_all();