extends Node3D

@onready var player = $Player
@onready var inventory_interface = $UI/InventoryInterface
const PickUp = preload("res://item/pick_up.tscn")
@onready var hot_bar_inventory = $UI/HotBarInventory

func _process(_delta):
	if len($Enemies.get_children()) == 0:
		$Portal.show()
		
# Called when the node enters the scene tree for the first time.
func _ready():
	hot_bar_inventory.set_inventory_data(player.inventory_data)
	inventory_interface.set_player_inventory_data(player.inventory_data)
	player.toggle_inventory.connect(toggle_inventory_interface)
	inventory_interface.force_close.connect(toggle_inventory_interface)
	for node in get_tree().get_nodes_in_group("external_inventory"):
		node.toggle_inventory.connect(toggle_inventory_interface)

func toggle_inventory_interface(external_inventory_owner = null):
	inventory_interface.visible = not inventory_interface.visible
	if inventory_interface.visible:
		hot_bar_inventory.hide()
		Input.mouse_mode = Input.MOUSE_MODE_VISIBLE
	else:
		hot_bar_inventory.show()
		Input.mouse_mode = Input.MOUSE_MODE_CAPTURED
	if external_inventory_owner and inventory_interface.visible:
		inventory_interface.set_external_inventory(external_inventory_owner)
		
	if not external_inventory_owner:
		inventory_interface.clear_external_inventory()


func _on_inventory_interface_drop_slot_data(slot_data):
	var pick_up = PickUp.instantiate()
	pick_up.slot_data = slot_data
	pick_up.position = PlayerManager.player.get_drop_position()
	add_child(pick_up)
