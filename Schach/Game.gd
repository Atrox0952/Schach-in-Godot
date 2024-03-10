extends Control

var Selected_Node = ""
var Turn = 0

var Location_X = ""
var Location_Y = ""

var pos = Vector2(25, 25)
var Areas: PackedStringArray

var Special_Area: PackedStringArray

func Update_Game(node):
	Selected_Node = ""
	if Turn == 0:
		Turn = 1
	else:
		Turn = 0
	
	var things = get_node("Flow").get_children()
	for i in things:
		if i.get_child_count() != 0 && i.get_child(0).name == "Pawn" && i.get_child(0).Item_Color == Turn && i.get_child(0).En_Passant == true:
			i.get_child(0).set("En_Passant", false)

	if node.get_child(0).name == "Pawn":
		if node.get_child(0).Double_Start == true:
			node.get_child(0).En_Passant = true
		node.get_child(0).Double_Start = false
	if node.get_child(0).name == "King":
		node.get_child(0).Castling = false
	if node.get_child(0).name == "Rook":
		node.get_child(0).Castling = false

func Get_Moveable_Areas():
	var Flow = get_node("Flow")
	Areas.clear()
	Special_Area.clear()
	var Piece = get_node("Flow/" + Selected_Node).get_child(0)
	if Piece.name == "Pawn":
		Get_Pawn(Piece, Flow)
	elif Piece.name == "Bishop":
		Get_Diagonals(Flow)
	elif Piece.name == "King":
		Get_Around(Piece)
	elif Piece.name == "Queen":
		Get_Diagonals(Flow)
		Get_Rows(Flow)
	elif Piece.name == "Rook":
		Get_Rows(Flow)
	elif Piece.name == "Knight":
		Get_Horse()

func Get_Pawn(Piece, Flow):
	if Piece.Item_Color == 0:
		if not Is_Null(Location_X + "-" + str(int(Location_Y) - 1)) && Flow.get_node(Location_X + "-" + str(int(Location_Y) - 1)).get_child_count() == 0:
			Areas.append(Location_X + "-" + str(int(Location_Y) - 1))
		if not Is_Null(Location_X + "-" + str(int(Location_Y) - 2)) && Piece.Double_Start == true && Flow.get_node(Location_X + "-" + str(int(Location_Y) - 2)).get_child_count() == 0:
			Areas.append(Location_X + "-" + str(int(Location_Y) - 2))
		if not Is_Null(str(int(Location_X) - 1) + "-" + str(int(Location_Y) - 1)) && Flow.get_node(str(int(Location_X) - 1) + "-" + str(int(Location_Y) - 1)).get_child_count() == 1:
			Areas.append(str(int(Location_X) - 1) + "-" + str(int(Location_Y) - 1))
		if not Is_Null(str(int(Location_X) + 1) + "-" + str(int(Location_Y) - 1)) && Flow.get_node(str(int(Location_X) + 1) + "-" + str(int(Location_Y) - 1)).get_child_count() == 1:
			Areas.append(str(int(Location_X) + 1) + "-" + str(int(Location_Y) - 1))
		if not Is_Null(str(int(Location_X) - 1) + "-" + Location_Y) && not Is_Null(str(int(Location_X) - 1) + "-" + str(int(Location_Y) - 1)):
			if Flow.get_node(str(int(Location_X) - 1) + "-" + Location_Y).get_child_count() == 1 && Flow.get_node(str(int(Location_X) - 1) + "-" + str(int(Location_Y) - 1)).get_child_count() != 1:
				Special_Area.append(str(int(Location_X) - 1) + "-" + Location_Y)
				Special_Area.append(str(int(Location_X) - 1) + "-" + str(int(Location_Y) - 1))
		if not Is_Null(str(int(Location_X) + 1) + "-" + Location_Y) && not Is_Null(str(int(Location_X) + 1) + "-" + str(int(Location_Y) - 1)):
			if Flow.get_node(str(int(Location_X) + 1) + "-" + Location_Y).get_child_count() == 1 && Flow.get_node(str(int(Location_X) + 1) + "-" + str(int(Location_Y) - 1)).get_child_count() != 1:
				Special_Area.append(str(int(Location_X) + 1) + "-" + Location_Y)
				Special_Area.append(str(int(Location_X) + 1) + "-" + str(int(Location_Y) - 1))
	else:
		if not Is_Null(Location_X + "-" + str(int(Location_Y) + 1)) && Flow.get_node(Location_X + "-" + str(int(Location_Y) + 1)).get_child_count() == 0:
			Areas.append(Location_X + "-" + str(int(Location_Y) + 1))
		if not Is_Null(Location_X + "-" + str(int(Location_Y) + 2)) && Piece.Double_Start == true && Flow.get_node(Location_X + "-" + str(int(Location_Y) + 2)).get_child_count() == 0:
			Areas.append(Location_X + "-" + str(int(Location_Y) + 2))
		if not Is_Null(str(int(Location_X) - 1) + "-" + str(int(Location_Y) + 1)) && Flow.get_node(str(int(Location_X) - 1) + "-" + str(int(Location_Y) + 1)).get_child_count() == 1:
			Areas.append(str(int(Location_X) - 1) + "-" + str(int(Location_Y) + 1))
		if not Is_Null(str(int(Location_X) + 1) + "-" + str(int(Location_Y) + 1)) && Flow.get_node(str(int(Location_X) + 1) + "-" + str(int(Location_Y) + 1)).get_child_count() == 1:
			Areas.append(str(int(Location_X) + 1) + "-" + str(int(Location_Y) + 1))
		if not Is_Null(str(int(Location_X) - 1) + "-" + Location_Y) && not Is_Null(str(int(Location_X) - 1) + "-" + str(int(Location_Y) + 1)):
			if Flow.get_node(str(int(Location_X) - 1) + "-" + Location_Y).get_child_count() == 1 && Flow.get_node(str(int(Location_X) - 1) + "-" + str(int(Location_Y) + 1)).get_child_count() != 1:
				Special_Area.append(str(int(Location_X) - 1) + "-" + Location_Y)
				Special_Area.append(str(int(Location_X) - 1) + "-" + str(int(Location_Y) + 1))
		if not Is_Null(str(int(Location_X) + 1) + "-" + Location_Y) && not Is_Null(str(int(Location_X) + 1) + "-" + str(int(Location_Y) + 1)):
			if Flow.get_node(str(int(Location_X) + 1) + "-" + Location_Y).get_child_count() == 1 && Flow.get_node(str(int(Location_X) + 1) + "-" + str(int(Location_Y) + 1)).get_child_count() != 1:
				Special_Area.append(str(int(Location_X) + 1) + "-" + Location_Y)
				Special_Area.append(str(int(Location_X) + 1) + "-" + str(int(Location_Y) + 1))

func _on_flow_send_location(location: String):
	var number = 0
	Location_X = ""
	var node = get_node("Flow/" + location)
	while location.substr(number, 1) != "-":
		Location_X += location.substr(number, 1)
		number += 1
	Location_Y = location.substr(number + 1)
	if Selected_Node == "" && node.get_child_count() != 0 && node.get_child(0).Item_Color == Turn:
		Selected_Node = location
		Get_Moveable_Areas()
	elif Selected_Node != "" && node.get_child_count() != 0 && node.get_child(0).Item_Color == Turn && node.get_child(0).name == "Rook":
		for i in Areas:
			if i == node.name:
				var king = get_node("Flow/" + Selected_Node).get_child(0)
				var rook = node.get_child(0)
				king.reparent(get_node("Flow/" + Special_Area[1]))
				rook.reparent(get_node("Flow/" + Special_Area[0]))
				king.position = pos
				rook.position = pos
				Update_Game(king.get_parent())
	elif Selected_Node != "" && node.get_child_count() != 0 && node.get_child(0).Item_Color != Turn && node.get_child(0).name == "Pawn" && Special_Area.size() != 0 && Special_Area[0] == node.name && node.get_child(0).get("En_Passant") == true:
		for i in Special_Area:
			if i == node.name:
				var pawn = get_node("Flow/" + Selected_Node).get_child(0)
				node.get_child(0).free()
				pawn.reparent(get_node("Flow/" + Special_Area[1]))
				pawn.position = pos
				Update_Game(pawn.get_parent())
	elif Selected_Node != "" && node.get_child_count() != 0 && node.get_child(0).Item_Color == Turn:
		Selected_Node = location
		Get_Moveable_Areas()
	elif Selected_Node != "" && node.get_child_count() != 0 && node.get_child(0).Item_Color != Turn:
		for i in Areas:
			if i == node.name:
				var Piece = get_node("Flow/" + Selected_Node).get_child(0)
				if node.get_child(0).name == "King":
					print("Gewonnen")
				node.get_child(0).free()
				Piece.reparent(node)
				Piece.position = pos
				Update_Game(node)
	elif Selected_Node != "" && node.get_child_count() == 0:
		for i in Areas:
			if i == node.name:
				var Piece = get_node("Flow/" + Selected_Node).get_child(0)
				Piece.reparent(node)
				Piece.position = pos
				Update_Game(node)

func Get_Around(Piece):
	if not Is_Null(Location_X + "-" + str(int(Location_Y) + 1)):
		Areas.append(Location_X + "-" + str(int(Location_Y) + 1))
	if not Is_Null(Location_X + "-" + str(int(Location_Y) - 1)):
		Areas.append(Location_X + "-" + str(int(Location_Y) - 1))
	if not Is_Null(str(int(Location_X) + 1) + "-" + Location_Y):
		Areas.append(str(int(Location_X) + 1) + "-" + Location_Y)
	if not Is_Null(str(int(Location_X) - 1) + "-" + Location_Y):
		Areas.append(str(int(Location_X) - 1) + "-" + Location_Y)
	if not Is_Null(str(int(Location_X) + 1) + "-" + str(int(Location_Y) + 1)):
		Areas.append(str(int(Location_X) + 1) + "-" + str(int(Location_Y) + 1))
	if not Is_Null(str(int(Location_X) - 1) + "-" + str(int(Location_Y) + 1)):
		Areas.append(str(int(Location_X) - 1) + "-" + str(int(Location_Y) + 1))
	if not Is_Null(str(int(Location_X) + 1) + "-" + str(int(Location_Y) - 1)):
		Areas.append(str(int(Location_X) + 1) + "-" + str(int(Location_Y) - 1))
	if not Is_Null(str(int(Location_X) - 1) + "-" + str(int(Location_Y) - 1)):
		Areas.append(str(int(Location_X) - 1) + "-" + str(int(Location_Y) - 1))
	if Piece.Castling == true:
		Castle()

func Get_Rows(Flow):
	var Add_X = 1
	while not Is_Null(str(int(Location_X) + Add_X) + "-" + Location_Y):
		Areas.append(str(int(Location_X) + Add_X) + "-" + Location_Y)
		if Flow.get_node(str(int(Location_X) + Add_X) + "-" + Location_Y).get_child_count() != 0:
			break
		Add_X += 1
	Add_X = 1
	while not Is_Null(str(int(Location_X) - Add_X) + "-" + Location_Y):
		Areas.append(str(int(Location_X) - Add_X) + "-" + Location_Y)
		if Flow.get_node(str(int(Location_X) - Add_X) + "-" + Location_Y).get_child_count() != 0:
			break
		Add_X += 1
	var Add_Y = 1
	while not Is_Null(Location_X + "-" + str(int(Location_Y) + Add_Y)):
		Areas.append(Location_X + "-" + str(int(Location_Y) + Add_Y))
		if Flow.get_node(Location_X + "-" + str(int(Location_Y) + Add_Y)).get_child_count() != 0:
			break
		Add_Y += 1
	Add_Y = 1
	while not Is_Null(Location_X + "-" + str(int(Location_Y) - Add_Y)):
		Areas.append(Location_X + "-" + str(int(Location_Y) - Add_Y))
		if Flow.get_node(Location_X + "-" + str(int(Location_Y) - Add_Y)).get_child_count() != 0:
			break
		Add_Y += 1

func Get_Horse():
	var The_X = 2
	var The_Y = 1
	var number = 0
	while number != 8:
		if not Is_Null(str(int(Location_X) + The_X) + "-" + str(int(Location_Y) + The_Y)):
			Areas.append(str(int(Location_X) + The_X) + "-" + str(int(Location_Y) + The_Y))
		number += 1
		match number:
			1:
				The_X = 1
				The_Y = 2
			2:
				The_X = -2
				The_Y = 1
			3:
				The_X = -1
				The_Y = 2
			4:
				The_X = 2
				The_Y = -1
			5:
				The_X = 1
				The_Y = -2
			6:
				The_X = -2
				The_Y = -1
			7:
				The_X = -1
				The_Y = -2

func Get_Diagonals(Flow):
	var Add_X = 1
	var Add_Y = 1
	while not Is_Null(str(int(Location_X) + Add_X) + "-" + str(int(Location_Y) + Add_Y)):
		Areas.append(str(int(Location_X) + Add_X) + "-" + str(int(Location_Y) + Add_Y))
		if Flow.get_node(str(int(Location_X) + Add_X) + "-" + str(int(Location_Y) + Add_Y)).get_child_count() != 0:
			break
		Add_X += 1
		Add_Y += 1
	Add_X = 1
	Add_Y = 1
	while not Is_Null(str(int(Location_X) - Add_X) + "-" + str(int(Location_Y) + Add_Y)):
		Areas.append(str(int(Location_X) - Add_X) + "-" + str(int(Location_Y) + Add_Y))
		if Flow.get_node(str(int(Location_X) - Add_X) + "-" + str(int(Location_Y) + Add_Y)).get_child_count() != 0:
			break
		Add_X += 1
		Add_Y += 1
	Add_X = 1
	Add_Y = 1
	while not Is_Null(str(int(Location_X) + Add_X) + "-" + str(int(Location_Y) - Add_Y)):
		Areas.append(str(int(Location_X) + Add_X) + "-" + str(int(Location_Y) - Add_Y))
		if Flow.get_node(str(int(Location_X) + Add_X) + "-" + str(int(Location_Y) - Add_Y)).get_child_count() != 0:
			break
		Add_X += 1
		Add_Y += 1
	Add_X = 1
	Add_Y = 1
	while not Is_Null(str(int(Location_X) - Add_X) + "-" + str(int(Location_Y) - Add_Y)):
		Areas.append(str(int(Location_X) - Add_X) + "-" + str(int(Location_Y) - Add_Y))
		if Flow.get_node(str(int(Location_X) - Add_X) + "-" + str(int(Location_Y) - Add_Y)).get_child_count() != 0:
			break
		Add_X += 1
		Add_Y += 1

func Castle():
	var Flow = get_node("Flow")
	var X_Counter = 1
	while not Is_Null(str(int(Location_X) + X_Counter) + "-" + Location_Y) && Flow.get_node(str(int(Location_X) + X_Counter) + "-" + Location_Y).get_child_count() == 0:
		X_Counter += 1
	if not Is_Null(str(int(Location_X) + X_Counter) + "-" + Location_Y) && Flow.get_node(str(int(Location_X) + X_Counter) + "-" + Location_Y).get_child(0).name == "Rook":
		if Flow.get_node(str(int(Location_X) + X_Counter) + "-" + Location_Y).get_child(0).Castling == true:
			Areas.append(str(int(Location_X) + X_Counter) + "-" + Location_Y)
			Special_Area.append(str(int(Location_X) + 1) + "-" + Location_Y)
			Special_Area.append(str(int(Location_X) + 2) + "-" + Location_Y)
	X_Counter = -1
	while not Is_Null(str(int(Location_X) + X_Counter) + "-" + Location_Y) && Flow.get_node(str(int(Location_X) + X_Counter) + "-" + Location_Y).get_child_count() == 0:
		X_Counter -= 1
	if not Is_Null(str(int(Location_X) + X_Counter) + "-" + Location_Y) && Flow.get_node(str(int(Location_X) + X_Counter) + "-" + Location_Y).get_child(0).name == "Rook":
		if Flow.get_node(str(int(Location_X) + X_Counter) + "-" + Location_Y).get_child(0).Castling == true:
			Areas.append(str(int(Location_X) + X_Counter) + "-" + Location_Y)
			Special_Area.append(str(int(Location_X) - 1) + "-" + Location_Y)
			Special_Area.append(str(int(Location_X) - 2) + "-" + Location_Y)

func Is_Null(Location):
	if get_node_or_null("Flow/" + Location) == null:
		return true
	else:
		return false
