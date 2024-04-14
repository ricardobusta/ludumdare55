extends Node

@onready var text_field: RichTextLabel = $Control/VBoxContainer/RichTextLabel
@onready var input_field: LineEdit = $Control/VBoxContainer/LineEdit

var room_config: RoomConfig = RoomConfig.new()

var current_room: int = 1

var started: bool = false

func _ready() -> void:
    input_field.grab_focus()
    input_field.text_submitted.connect(_on_text_submitted)
    text_field.clear()

    _print_text("[color=#ff0099][code]
 _____  _           _____
|_   _|| |_  ___   |   __| _ _  _____  _____  ___  ___  ___  ___
  | |  |   || -_|  |__   || | ||     ||     || . ||   || -_||  _|
  |_|  |_|_||___|  |_____||___||_|_|_||_|_|_||___||_|_||___||_|
[/code]\n
Text based adventure by Ricardo Bustamante <ricardo@busta.dev>[/color]")
    _print_text("Ludum Dare 55 - 13.04.24\n\n")

    _print_text("Type anything to start")

func _on_text_submitted(text: String) -> void:
    input_field.clear()
    text = text.strip_edges(true, true).to_lower()
    if(text.is_empty()):
        return;
    text_field.append_text("[color=#999]%s[/color]\n" % text)
    _parse_command(text)
    text_field.append_text("\n[color=#999]> [/color]")

func _print_text(text: String) -> void:
    text_field.append_text(text + "\n")

func _parse_command(command: String) -> void:
    var res = command.split(" ", false)

    if(!started):
        text_field.clear()
        _print_text("[color=#ffff00]You wake up in a dark room. \
Your eyes start getting used to the darkness. You feel like \
exploring and trying to understand where you are, and maybe \
you will figure out how did you end up here.[/color]\n\n")
        _print_text(_room().print_complete(room_config))
        started = true
        return

    match res[0]:
        "look", "l", "ls":
            _handle_look(_safe_get_param_1(res))
        "move", "m", "mv":
            _handle_move(_safe_get_param_1(res))
        "clear", "cls", "cl", "c":
            text_field.clear()
            _print_text(_room().print_complete(room_config))
        "open", "o":
            _handle_open(_safe_get_param_1(res))
        "help", "h":
            _print_text("Some things I could try:\nLook\tMove\tHelp\tClear\tOpen")
        _:
            _print_text("I am not sure how to `[i]%s[/i]`. Maybe I need to ask for `[i]help[/i]`." % res[0])

func _safe_get_param_1(res: Array) -> String:
    return "" if res.size() < 2 else _parse_direction(res[1])

func _handle_look(target: String):
    if(target.is_empty()):
        _print_text("You look at your surroundings")
        _print_text(_room().print_complete(room_config))
    else:
        match target:
            "north", "south", "east", "west":
                var room = _room_at_direction(target)
                if(room != null):
                    var door_id = _door_id_at_direction(target)
                    if(door_id > 0 && room_config.doors[door_id].closed):
                        _print_text("You see %s to the %s." % [room_config.doors[door_id].description, target])
                    else:
                        _print_text("You look at the next room to the %s:" % target)
                        _print_text(room.print_complete(room_config))
                else:
                    _print_text("There's no exit at that direction...")
            "directions", "exits", "exit":
                _print_text("You look at the available exits")
                _print_text(_room().print_exits(room_config))
            _:
                _print_text("There's no %s to be looked at..." % target)

func _parse_direction(direction: String) -> String:
    match(direction):
        "north", "nort", "nor", "no", "n":
            return "north"
        "south", "sout", "sou", "so", "s":
            return "south"
        "east", "eas", "ea", "e":
            return "east"
        "west", "wes", "we", "w":
            return "west"
        "up", "u":
            return "up"
        "down", "dow", "do", "d":
            return "down"
        _:
            return direction

func _door_id_at_direction(direction: String) -> int:
    match(direction):
        "north":
            return _room().door_north
        "south":
            return _room().door_south
        "east":
            return _room().door_east
        "west":
            return _room().door_west
        "up":
            return _room().door_up
        "down":
            return _room().door_down
        _:
            return 0

func _handle_move(target: String) -> void:
    if(target.is_empty()):
        _print_text("I must move torwards a direction...")
        _print_text(_room().print_complete(room_config))
    else:
        var target_room = _room_id_at_direction(target)
        if(target_room < 1):
            _print_text("There's no room to the %s." % target)
        else:
            var door_id = _door_id_at_direction(target)
            if(door_id > 0 && room_config.doors[door_id].closed):
                _print_text("The %s to the %s is closed, blocking your way." % [room_config.doors[door_id].description, target])
            else:
                _print_text("You move %s." % target)
                current_room = target_room
                _print_text(_room().print_complete(room_config))

func _handle_open(target: String):
    if(target.is_empty()):
        _print_text("Open what?")
        return
    match(target):
        "north", "south", "east", "west", "up", "down":
            var door_id = _door_id_at_direction(target)
            if(door_id > 0):
                if(room_config.doors[door_id].closed):
                    room_config.doors[door_id].closed = false
                    _print_text("Door to the %s was opened." % target)
                else:
                    _print_text("Door to the %s was already open." % target)
            else:
                _print_text("There's nothing to open at %s direction." % target)
        _:
            _print_text("Open %s." % target)

func _room() -> Room:
    return room_config.rooms[current_room]

func _room_id_at_direction(direction: String) -> int:
    var room = 0
    match(direction):
        "north":
            room = _room().exit_north
        "south":
            room = _room().exit_south
        "east":
            room = _room().exit_east
        "west":
            room = _room().exit_west
        "up":
            room = _room().exit_up
        "down":
            room = _room().exit_down
        _:
            room = 0
    return room

func _room_at_direction(direction: String) -> Room:
    var room = _room_id_at_direction(direction)
    return null if room < 1 else room_config.rooms[room]
