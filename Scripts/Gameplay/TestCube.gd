extends MeshInstance3D


func _physics_process(delta):
	rotate_y(5.0*delta)
