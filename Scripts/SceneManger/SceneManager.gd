extends Node


@onready var loading_scene  = preload("res://Scenes/LoadingScene/LoadingScene.tscn")

func load_scene(current_scene,next_scene: String):
	var loading_scene_instance = loading_scene.instantiate()
	var progress_bar = loading_scene_instance.get_node("LoadingBar") as ProgressBar

	progress_bar.value = 0.0
	get_tree().get_root().call_deferred("add_child",loading_scene_instance)
	ResourceLoader.load_threaded_request(next_scene)
	current_scene.queue_free()
	await get_tree().create_timer(0.5).timeout
	
	while true:
		var array = []
		var status = ResourceLoader.load_threaded_get_status(next_scene, array)
		if status == ResourceLoader.THREAD_LOAD_LOADED:
			var scn = ResourceLoader.load_threaded_get(next_scene).instantiate()
			get_tree().get_root().call_deferred("add_child",scn)
			loading_scene_instance.queue_free()
			return
		elif status != ResourceLoader.THREAD_LOAD_IN_PROGRESS:
			progress_bar.value = float(array[0] * 100.0)
		else:
			print("error loading new scene")
			return
