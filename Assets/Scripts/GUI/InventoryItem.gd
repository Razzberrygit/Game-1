class_name InventoryItem
extends TextureRect

var itemCount: int = 1
var data: ItemData
@onready var countLabel = Label.new()

func init(d: ItemData) -> void:
	data = d

func _ready() -> void:
	expand_mode = TextureRect.EXPAND_IGNORE_SIZE
	stretch_mode = TextureRect.STRETCH_KEEP_ASPECT_CENTERED
	texture = data.texture
	custom_minimum_size = data.customMinimumSize
	
	countLabel.set_anchors_preset(Control.PRESET_FULL_RECT)
	countLabel.horizontal_alignment = HORIZONTAL_ALIGNMENT_RIGHT
	countLabel.vertical_alignment = VERTICAL_ALIGNMENT_BOTTOM
	countLabel.add_theme_font_size_override("font", 20)
	add_child(countLabel)
	UpdateItemCount()

func UpdateItemCount() -> void:
	if itemCount == 1:
		countLabel.visible = false
	else:
		countLabel.visible = true
	countLabel.text = str(itemCount)
