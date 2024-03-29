@tool
extends EditorPlugin


func _enter_tree():
	# Initialization of the plugin goes here.
	add_custom_type("Pawn", "Sprite2D", preload("res://addons/Chess/Scripts/Pawn.gd"), preload("res://addons/Chess/Textures/WPawn.svg"))
	add_custom_type("King", "Sprite2D", preload("res://addons/Chess/Scripts/King.gd"), preload("res://addons/Chess/Textures/WKing.svg"))
	add_custom_type("Bishop", "Sprite2D", preload("res://addons/Chess/Scripts/Bishop.gd"), preload("res://addons/Chess/Textures/WBishop.svg"))
	add_custom_type("Knight", "Sprite2D", preload("res://addons/Chess/Scripts/Knight.gd"), preload("res://addons/Chess/Textures/WKnight.svg"))
	add_custom_type("Queen", "Sprite2D", preload("res://addons/Chess/Scripts/Queen.gd"), preload("res://addons/Chess/Textures/WQueen.svg"))
	add_custom_type("Rook", "Sprite2D", preload("res://addons/Chess/Scripts/Rook.gd"), preload("res://addons/Chess/Textures/WRook.svg"))


func _exit_tree():
	# Clean-up of the plugin goes here.
	remove_custom_type("Pawn")
	remove_custom_type("King")
	remove_custom_type("Bishop")
	remove_custom_type("Knight")
	remove_custom_type("Queen")
	remove_custom_type("Rook")
