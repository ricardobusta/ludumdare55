extends Node

@onready var text_field: RichTextLabel = $Control/VBoxContainer/RichTextLabel
@onready var input_field: LineEdit = $Control/VBoxContainer/LineEdit

func _ready() -> void:
    input_field.text_submitted.connect(_on_text_submitted)


func _on_text_submitted(text: String) -> void:
    print(input_field.text)
    input_field.clear()
