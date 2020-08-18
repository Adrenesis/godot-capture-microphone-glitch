extends Node

signal packet_sent
signal packet_received

const MIN_PACKET_LENGTH = 0.25
const STARTUP_TIME = 5.0
var mic_number = 300
var mics = []
var record
var time_elapsed_since_record = 0
var time_elapsed = 0


func _ready():
	for i in range(mic_number):
		AudioServer.add_bus_effect(1, AudioEffectRecord.new(), i)
		var _mic = AudioServer.get_bus_effect(AudioServer.get_bus_index("Record"), i)
		_mic.set_recording_active(true)
		mics.push_back(_mic)
	
var debugFirstRound = false
func _process(delta: float) -> void:
	
	if time_elapsed >= STARTUP_TIME:
		if time_elapsed_since_record >= MIN_PACKET_LENGTH:
			print("reading mics...")
			for _mic in mics:
				_mic.set_recording_active(false)
				var r = _mic.get_recording()
				_mic.set_recording_active(true)
				time_elapsed_since_record = 0
	else:
		if time_elapsed_since_record >= MIN_PACKET_LENGTH:
			print("triggering mics...")
			for _mic in mics:
				_mic.set_recording_active(false)
				_mic.set_recording_active(true)
				time_elapsed_since_record = 0
	time_elapsed_since_record += delta
	time_elapsed += delta
