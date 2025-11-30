extends Node2D

var cor_contorno: Color = Color.WHITE
var cores_hexagono: PackedColorArray = []
var cor_estrela_contorno: Color = Color.YELLOW
var texture = preload("res://Assets/icon.svg")

func _ready():
	gerar_novas_cores()

func _draw():
	# 1. Triângulo (Contorno)
	var pontos_tri = criar_poligono_regular(3, 80, Vector2(150, 200))
	var pontos_fechados_tri = pontos_tri.duplicate()
	pontos_fechados_tri.append(pontos_tri[0])
	
	draw_polyline(pontos_fechados_tri, cor_contorno, 3.0)

	# 2. Hexágono (Interpolação de Cores)
	var pontos_hex = criar_poligono_regular(6, 80, Vector2(400, 200))
	draw_polygon(pontos_hex, cores_hexagono)

	# 3. Estrela (Com Textura)
	var centro_estrela = Vector2(680, 200)
	var pontos_estrela = criar_estrela(5, 40, 90, centro_estrela)
	
	var uvs = PackedVector2Array()
	var tam_tex = texture.get_size()
	
	for p in pontos_estrela:
		uvs.append((p - centro_estrela) / tam_tex + Vector2(0.5, 0.5))

	draw_colored_polygon(pontos_estrela, Color.WHITE, uvs, texture)
	
	var pontos_fechados_estrela = pontos_estrela.duplicate()
	pontos_fechados_estrela.append(pontos_estrela[0])
	draw_polyline(pontos_fechados_estrela, cor_estrela_contorno, 2.0)

func _input(event):
	if event is InputEventMouseButton and event.pressed and event.button_index == MOUSE_BUTTON_LEFT:
		gerar_novas_cores()
		queue_redraw()

func gerar_novas_cores():
	cor_contorno = Color(randf(), randf(), randf())
	cor_estrela_contorno = Color(randf(), randf(), randf())
	cores_hexagono.clear()
	for i in range(6):
		cores_hexagono.append(Color(randf(), randf(), randf()))

func criar_poligono_regular(lados: int, raio: float, centro: Vector2) -> PackedVector2Array:
	var pontos = PackedVector2Array()
	for i in range(lados):
		var angulo = deg_to_rad(i * 360.0 / lados - 90)
		var x = centro.x + cos(angulo) * raio
		var y = centro.y + sin(angulo) * raio
		pontos.append(Vector2(x, y))
	return pontos

func criar_estrela(pontas: int, r_int: float, r_ext: float, centro: Vector2) -> PackedVector2Array:
	var pontos = PackedVector2Array()
	var angulo_passo = PI / pontas
	var angulo = -PI / 2
	for i in range(pontas * 2):
		var raio = r_ext if i % 2 == 0 else r_int
		var x = centro.x + cos(angulo) * raio
		var y = centro.y + sin(angulo) * raio
		pontos.append(Vector2(x, y))
		angulo += angulo_passo
	return pontos
