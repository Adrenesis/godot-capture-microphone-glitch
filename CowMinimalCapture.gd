extends Node

const MIN_PACKET_LENGTH = 0.180
const STARTUP_TIME = 1.0
var mic_number = 1
var record_number = 30
var mic : AudioEffectRecord
var time_elapsed_since_record = 0
var time_elapsed = 0
var triggering_mic_down = false
var triggering_mic_up = false

func _ready():
	AudioServer.add_bus_effect(1, AudioEffectRecord.new(), 0)
	mic = AudioServer.get_bus_effect(AudioServer.get_bus_index("Record"), 0)
	mic.set_recording_active(true)
	
var debugFirstRound = false
func _process(delta: float) -> void:
	if time_elapsed >= STARTUP_TIME:
		if time_elapsed_since_record >= MIN_PACKET_LENGTH and mic.get_recording_size() > 0:
			print("reading mics... of " + str(mic.get_recording_size()))
			for i in range(record_number):
				if i % 15 == 0:
					print(i)
					pass
				var _r = mic.get_recording()
			mic.set_recording_active(true) 
#				yield(get_tree(), "idle_frame")
				
			time_elapsed_since_record = 0
#				r.unreference()
		triggering_mic_down = true
#	else:
#		if time_elapsed_since_record >= MIN_PACKET_LENGTH:
#			print("triggering mics...")
#			for _mic in mics:
#				_mic.set_recording_active(false)
#				_mic.set_recording_active(true)
#				time_elapsed_since_record = 0
	time_elapsed_since_record += delta
	time_elapsed += delta
