extends Object

class_name Room

var name: String = "Room Name"
var description: String = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
var exit_north: int = -1
var exit_south: int = -1
var exit_east: int = -1
var exit_west: int = -1

func set_name(name: String) -> Room:
    self.name = name
    return self

func set_description(description: String) -> Room:
    self.description = description
    return self

func set_exits(north: int = 0, south: int = 0, east: int = 0, west: int = 0) -> Room:
    self.exit_north = north
    self.exit_south = south
    self.exit_east = east
    self.exit_west = west
    return self

func print_exits() -> String:
    var text = "Exits:"
    var has_exit = false;
    if(exit_north > 0):
        text += " N"
        has_exit = true
    if(exit_east > 0):
        text += " E"
        has_exit = true
    if(exit_south > 0):
        text += " S"
        has_exit = true
    if(exit_west > 0):
        text += " W"
        has_exit = true
    if(!has_exit):
        text += "None"
    return text

func print_complete() -> String:
    var text = "[color=#f0f][b]%s[/b][/color]\n%s\n" % [name, description]
    text += print_exits()
    return text
