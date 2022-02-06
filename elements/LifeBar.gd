# Write your doc string for this file here
tool
extends MarginContainer

### Member Variables and Dependencies -------------------------------------------------------------
#--- signals --------------------------------------------------------------------------------------

#--- enums ----------------------------------------------------------------------------------------

#--- constants ------------------------------------------------------------------------------------

#--- public variables - order: export > normal var > onready --------------------------------------

#--- private variables - order: export > normal var > onready -------------------------------------

#sv-export
var _health_max: IntVariable = IntVariable.new()
#sv-export
var _health_current: IntVariable = IntVariable.new()

onready var _resources: ResourcePreloader = $ResourcePreloader
onready var _root: GridContainer = $Root

### -----------------------------------------------------------------------------------------------


### Built in Engine Methods -----------------------------------------------------------------------

func _ready() -> void:
	_health_max.connect_to(self, "_on_health_max_value_updated")
	_health_current.connect_to(self, "_on_health_current_value_updated")
	populate()
	pass

### -----------------------------------------------------------------------------------------------


### Public Methods --------------------------------------------------------------------------------

func populate() -> void:
	_clear()
	
	_handle_max_hearts()
	_handle_current_hp()

### -----------------------------------------------------------------------------------------------


### Private Methods -------------------------------------------------------------------------------

func _handle_max_hearts() -> void:
	var max_hearts = ceil(_health_max.value / 2.0)
	
	for _index in range(max_hearts):
		var new_heart: Control = _resources.get_resource("HeartUi").instance()
		_root.add_child(new_heart)
	
	_health_current.value = min(_health_current.value, _health_max.value)


func _handle_current_hp() -> void:
	var full_hearts: int = floor(_health_current.value / 2.0)
	var half_hearts: = _health_current.value % 2
	
	for index in _root.get_child_count():
		var heart = _root.get_child(index)
		if index < full_hearts:
			heart.value = 2
		elif index == full_hearts and half_hearts > 0:
			heart.value = 1
		else:
			heart.value = 0


func _clear() -> void:
	for child in _root.get_children():
		_root.remove_child(child)
		child.queue_free()


func _on_health_max_value_updated() -> void:
	populate()

func _on_health_current_value_updated() -> void:
	_handle_current_hp()

### -----------------------------------------------------------------------------------------------
