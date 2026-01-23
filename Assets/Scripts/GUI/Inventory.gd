extends Node

var displayInventory: Node
var items: Array[InventoryItem]

func AddItem(itemID: int, addItemCount: int) -> void:
	for i in items.size():
		if items[i].data.itemID == itemID:
			items[i].itemCount += addItemCount
			items[i].UpdateItemCount()
			return
	_AddNewItem(itemID, addItemCount)

func _AddNewItem(itemID: int, addItemCount: int) -> void:
	var item := InventoryItem.new()
	item.init(load(Global.GetItemResourcePath(itemID)))
	item.itemCount = addItemCount
	displayInventory.add_child(item)
	items.append(item)

func SubtractItem(itemID: int, subtractItemCount) -> void:
	for i in items.size():
		if items[i].data.itemID == itemID:
			if items[i].itemCount >= subtractItemCount:
				items[i].itemCount -= subtractItemCount
				items[i].UpdateItemCount()
				if items[i].itemCount <= 0:
					displayInventory.remove_child(items[i])
					items.remove_at(i)

func HasItemCount(itemID: int, itemCount: int):
	for i in items.size():
		if items[i].data.itemID == itemID:
			if items[i].itemCount >= itemCount:
				return true
	return false

func Refresh() -> void:
	for i in items.size():
		var item := InventoryItem.new()
		item.itemCount = items[i].itemCount
		item.init(load(Global.GetItemResourcePath(items[i].data.itemID)))
		displayInventory.add_child(item)
		items[i] = item
