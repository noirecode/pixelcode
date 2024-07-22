extends AudioStreamPlayer

var songs = {
	
	"main": preload("res://Assets/Audio/pck404_cosy_bossa.ogg"),
	"forest": preload("res://Assets/Audio/pck404_lets_play.ogg"),
	"farm": preload("res://Assets/Audio/pck404_cheerful_dub.ogg")
}

func _play_music(music: AudioStream, volume = 0.0):
	if stream == music:
		return
	stream = music
	volume_db = volume
	bus = "Music"
	play()

func play_music_level(title):
	_play_music(songs[title])
