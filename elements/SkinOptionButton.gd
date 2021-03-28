# Write your doc string for this file here
tool
extends OptionButton

### Member Variables and Dependencies -------------------------------------------------------------
#--- signals --------------------------------------------------------------------------------------

#--- enums ----------------------------------------------------------------------------------------

#--- constants ------------------------------------------------------------------------------------

#--- public variables - order: export > normal var > onready --------------------------------------

#--- private variables - order: export > normal var > onready -------------------------------------

#sv-export
var _player_skin: PlayerSkinVariable = PlayerSkinVariable.new() setget _set_player_skin

### -----------------------------------------------------------------------------------------------


### Built in Engine Methods -----------------------------------------------------------------------

func _ready() -> void:
	connect("item_selected", self, "_on_item_selected")
	pass

### -----------------------------------------------------------------------------------------------


### Public Methods --------------------------------------------------------------------------------

### -----------------------------------------------------------------------------------------------


### Private Methods -------------------------------------------------------------------------------

func _on_item_selected(index: int) -> void:
	_player_skin.value = PlayerSkinVariable.PlayerSkin[get_item_text(index)]


func _on_player_skin_value_updated() -> void:
	selected = _player_skin.value


func _set_player_skin(value: PlayerSkinVariable) -> void:
	_player_skin = value
	
	if not is_inside_tree():
		yield(self, "ready")
	
	clear()
	for key in PlayerSkinVariable.PlayerSkin.keys():
		add_item(key)
	
	selected = _player_skin.value
	_player_skin.connect_to(self, "_on_player_skin_value_updated")

### -----------------------------------------------------------------------------------------------
