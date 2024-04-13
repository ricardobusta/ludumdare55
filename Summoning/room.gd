extends Object

class_name Room

var name: String = "Room Name"
var description: String = "Lorem ipsum dolor sit amet."
var exit_north: int = -1
var exit_south: int = -1
var exit_east: int = -1
var exit_west: int = -1

func set_name(room_name: String) -> Room:
    self.name = room_name
    return self

func set_description(room_description: String) -> Room:
    self.description = room_description
    return self

func set_exit_north(id: int) -> Room:
    self.exit_north = id
    return self

func set_exit_south(id: int) -> Room:
    self.exit_south = id
    return self

func set_exit_east(id: int) -> Room:
    self.exit_east = id
    return self

func set_exit_west(id: int) -> Room:
    self.exit_west = id
    return self

func print_exits() -> String:
    var text = "Exits:"
    var has_exit = false;
    if(exit_north > 0):
        text += " North"
        has_exit = true
    if(exit_east > 0):
        text += " East"
        has_exit = true
    if(exit_south > 0):
        text += " South"
        has_exit = true
    if(exit_west > 0):
        text += " West"
        has_exit = true
    if(!has_exit):
        text += " None"
    return text

func print_complete() -> String:
    var text = "[color=#f0f][b]%s[/b][/color]\n%s\n" % [name, description]
    text += print_exits()
    return text
