extends Node

@onready var text_field: RichTextLabel = $Control/VBoxContainer/RichTextLabel
@onready var input_field: LineEdit = $Control/VBoxContainer/LineEdit

var room_config: RoomConfig = RoomConfig.new()

var current_room: int = 1

func _ready() -> void:
    input_field.grab_focus()
    input_field.text_submitted.connect(_on_text_submitted)
    text_field.clear()

    var room: Room = room_config.rooms[current_room]
    _print_room(room)

func _on_text_submitted(text: String) -> void:
    input_field.clear()
    text = text.strip_edges(true, true)
    if(text.is_empty()):
        return;
    _print_text("\n[color=#999]> " + text + "[/color]")
    _parse_command(text)

func _print_text(text: String) -> void:
    text_field.append_text(text + "\n")

func _print_room(room: Room) -> void:
    text_field.append_text(room.printable())

func _parse_command(command: String) -> void:
    var res = command.split(" ", false)

    match res[0].to_lower():
        "look", "l":
            _handle_look("" if res.size() < 2 else res[1] )
        "move", "m":
            if(res.size()>1):
                _print_text("Move "+ res[1])
            else:
                _print_text("I must move torwards a direction...")
        "clear":
            text_field.clear()
            _parse_command("look")
        "help":
            _print_text("Some things I could try:\nLook\tMove\tHelp")
        _:
            _print_text("I am not sure how to `[i]%s[/i]`. Maybe I need to ask for `[i]help[/i]`." % res[0])

func _handle_look(target: String):
    if(target.is_empty()):
        _print_text("You look at your surroundings")
        _print_room(room_config.rooms[current_room])
    else:
        match target:
            _:
                _print_text("There's no %s to be looked at..." % target)
