/// @description Insert description here
// You can write your code in this editor
chart = global.doubleKillChart;
defaultControls = [[ord("Z"), ord("X"), vk_numpad1, vk_numpad2], [ord("A"), ord("S"), vk_up, vk_right], [ord("D"), ord("F"), ord("J"), ord("K")]];
for (var i=0; i<array_length(chart.strumLines); i++){ 
	chart.strumLines[i].downScroll = false;
	chart.strumLines[i].combo = 0;
	chart.strumLines[i].controls = defaultControls[i];
}
curStrumLine = undefined;
curStrum = undefined;
inputSelecting = false;

song = audio_play_sound(tutorials,0,0);
voicing = audio_play_sound(voicers,0,0);
audio_pause_all();