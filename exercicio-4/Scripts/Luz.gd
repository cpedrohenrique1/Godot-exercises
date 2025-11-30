extends SpotLight3D

var cores = [
	Color.RED,
	Color.BLUE,
	Color.GREEN,
	Color.YELLOW,
	Color.MAGENTA,
	Color.CYAN,
	Color.WHITE
]

var indice = 0

func _input(event):
	if event is InputEventMouseButton and event.pressed:
		indice = (indice + 1) % cores.size()
		light_color = cores[indice]
		print("Nova cor da luz:", light_color)
