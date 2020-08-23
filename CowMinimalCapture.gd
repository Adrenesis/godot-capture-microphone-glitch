extends Node

const MIN_PACKET_LENGTH = 0.180
const STARTUP_TIME = 1.0
var record_number = 50
var mic : AudioEffectRecord
var time_elapsed_since_record = 0
var time_elapsed = 0

func _ready():
	AudioServer.add_bus_effect(1, AudioEffectRecord.new(), 0)
	mic = AudioServer.get_bus_effect(AudioServer.get_bus_index("Record"), 0)
	mic.set_recording_active(true)
#	set_process(false)
	
var debugFirstRound = false
func _process(delta: float) -> void:
	if time_elapsed >= STARTUP_TIME:
		if time_elapsed_since_record >= MIN_PACKET_LENGTH:
			print("reading of mic:")
			for i in range(record_number):
				if i % 10 == 0:
					print(i)
				var _r = mic.get_recording()
			mic.set_recording_active(true)
			time_elapsed_since_record = 0
	time_elapsed_since_record += delta
	time_elapsed += delta
