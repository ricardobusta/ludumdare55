extends Node

@onready var text_field: RichTextLabel = $Control/VBoxContainer/RichTextLabel
@onready var input_field: LineEdit = $Control/VBoxContainer/LineEdit

var room_config: RoomConfig = RoomConfig.new()

var current_room: int = 1

func _ready() -> void:
    input_field.grab_focus()
    input_field.text_submitted.connect(_on_text_submitted)
    text_field.clear()

    _print_text(_room().print_complete())

func _on_text_submitted(text: String) -> void:
    input_field.clear()
    text = text.strip_edges(true, true).to_lower()
    if(text.is_empty()):
        return;
    _print_text("\n[color=#999]> " + text + "[/color]")
    _parse_command(text)

func _print_text(text: String) -> void:
    text_field.append_text(text + "\n")

func _parse_command(command: String) -> void:
    var res = command.split(" ", false)

    match res[0]:
        "look", "l":
            _handle_look("" if res.size() < 2 else res[1])
        "move", "m":
            _handle_move("" if res.size() < 2 else res[1])
        "clear", "cls", "cl", "c":
            text_field.clear()
            _print_text(_room().print_complete())
        "help":
            _print_text("Some things I could try:\nLook\tMove\tHelp")
        _:
            _print_text("I am not sure how to `[i]%s[/i]`. Maybe I need to ask for `[i]help[/i]`." % res[0])

func _handle_look(target: String):
    if(target.is_empty()):
        _print_text("You look at your surroundings")
        _print_text(_room().print_complete())
    else:
        match target:
            "north", "n", "south", "s", "east", "e", "west", "w":
                _print_text("You look at the next room:")
                _print_text(_room_at_direction(target).print_complete())
            "directions", "exits", "exit":
                _print_text("You look at the available exits")
                _print_text(_room().print_exits())
            _:
                _print_text("There's no %s to be looked at..." % target)

func _handle_move(target: String):
    if(target.is_empty()):
        _print_text("I must move torwards a direction...")
        _print_text(_room().print_complete())
    else:
        match(target):
            "north":
                _print_text("You are moving north")
            _:
                _print_text("There's no exit available to %s." % target)

func _room() -> Room:
    return room_config.rooms[current_room]

func _room_at_direction(direction: String) -> Room:
    var room = 0
    match(direction):
        "north", "n":
            room = _room().exit_north
        "south", "s":
            room = _room().exit_south
        "east", "e":
            room = _room().exit_east
        "west", "w":
            room = _room().exit_west
        _:
            room = 0
    return null if room < 1 else room_config.rooms[room]
