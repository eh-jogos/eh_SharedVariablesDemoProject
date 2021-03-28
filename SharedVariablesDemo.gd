# Write your doc string for this file here
tool
extends Control

### Member Variables and Dependencies -------------------------------------------------------------
#--- signals --------------------------------------------------------------------------------------

#--- enums ----------------------------------------------------------------------------------------

#--- constants ------------------------------------------------------------------------------------

const MAX_HP = 48

#--- public variables - order: export > normal var > onready --------------------------------------

#--- private variables - order: export > normal var > onready -------------------------------------

export(String, FILE) var _save_location: String = "user://save.json"

#sv-export
var _player_hp_max: IntVariable = IntVariable.new()
#sv-export
var _player_hp_current: IntVariable = IntVariable.new()
#sv-export
var _player_name: StringVariable = StringVariable.new()
#sv-export
var _player_skin: IntVariable = IntVariable.new()

onready var _load_button: Button = $VBoxContainer/Menu/Load

### -----------------------------------------------------------------------------------------------


### Built in Engine Methods -----------------------------------------------------------------------

func _ready() -> void:
	var file:= File.new()
	if file.file_exists(_save_location):
		_load_button.disabled = false
	else:
		_load_button.disabled = true

### -----------------------------------------------------------------------------------------------


### Public Methods --------------------------------------------------------------------------------

### -----------------------------------------------------------------------------------------------


### Private Methods -------------------------------------------------------------------------------

func _on_MaxHpUpgrade_pressed() -> void:
	_player_hp_max.value = min(_player_hp_max.value + 2, MAX_HP)


func _on_TakeDamage_pressed() -> void:
	_player_hp_current.value = max(_player_hp_current.value - 1, 0)


func _on_Heal_pressed() -> void:
	_player_hp_current.value = min(_player_hp_current.value + 3, _player_hp_max.value)


func _on_Save_pressed() -> void:
	var save_dict: Dictionary = {}
	var elements_to_save = ["_player_hp_current", "_player_hp_max", "_player_name", "_player_skin"]
	
	for index in elements_to_save.size():
		var shared_variable: SharedVariable = get(elements_to_save[index])
		save_dict[elements_to_save[index]] = shared_variable.get_dict()
	
	var file: File = File.new()
	file.open(_save_location, File.WRITE)
	file.store_string(var2str(save_dict))
	file.close()
	
	if _load_button.disabled:
		_load_button.disabled = false


func _on_Load_pressed() -> void:
	var file: File = File.new()
	file.open(_save_location, File.READ)
	var loaded_data: String = file.get_as_text()
	file.close()
	
	var loaded_dict: Dictionary = str2var(loaded_data)
	
	for variable in loaded_dict.keys():
		var shared_variable: SharedVariable = get(variable)
		shared_variable.load_dict(loaded_dict[variable])

### -----------------------------------------------------------------------------------------------
