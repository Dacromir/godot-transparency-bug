tool
extends Spatial

export var update = false # setget update
export var sphere_range = 3

func _ready():
	pass

# Used to generate the spheres automatically (easier than placing one-by-one)
func update(new_val):
	var sphere_container = $Spheres
	var nav_node = preload("res://Sphere.tscn")
	
	for child in sphere_container.get_children():
		child.free()
	
	for x in range(-1 * sphere_range, sphere_range + 1):
		for y in range(-1 * sphere_range, sphere_range + 1):
			for z in range(-1 * sphere_range, sphere_range + 1):
				if x==0 and y==0 and z==0:
					continue
				
				var new_node = nav_node.instance()
				new_node.translation = Vector3(x+0.5,y+0.5,z+0.5)
				new_node.name = str(x) + "," + str(y) + "," + str(z)
				
				new_node.set_owner(get_owner())
				sphere_container.add_child(new_node)
				new_node.set_owner(get_tree().get_edited_scene_root())
