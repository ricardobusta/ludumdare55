extends Object

class_name Room

var name: String = "Room Name"
var description: String = "Lorem ipsum dolor sit amet."
var exit_north: int = 0
var door_north: int = 0
var exit_south: int = 0
var door_south: int = 0
var exit_east: int = 0
var door_east: int = 0
var exit_west: int = 0
var door_west: int = 0
var exit_up: int = 0
var door_up: int = 0
var exit_down: int = 0
var door_down: int = 0
var objects: Array = []

func set_name(room_name: String) -> Room:
    self.name = room_name
    return self

func set_description(room_description: String) -> Room:
    self.description = room_description
    return self

func set_exit_north(id: int, door: int) -> Room:
    self.exit_north = id
    self.door_north = door
    return self

func set_exit_south(id: int, door: int) -> Room:
    self.exit_south = id
    self.door_south = door
    return self

func set_exit_east(id: int, door: int) -> Room:
    self.exit_east = id
    self.door_east = door
    return self

func set_exit_west(id: int, door: int) -> Room:
    self.exit_west = id
    self.door_west = door
    return self

func set_exit_up(id: int, door: int) -> Room:
    self.exit_up = id
    self.door_up = door
    return self

func set_exit_down(id: int, door: int) -> Room:
    self.exit_down = id
    self.door_down = door
    return self

func add_object(object: GameObject) -> Room:
    self.objects.push_back(object)
    return self

func print_exits(room_config: RoomConfig) -> String:
    var text = "[color=#ff9933]Exits:[/color]"
    var has_exit = false;
    var doors = room_config.doors
    if(exit_north > 0):
        text += get_dir_text("North", door_north, doors)
        has_exit = true
    if(exit_east > 0):
        text += get_dir_text("East", door_east, doors)
        has_exit = true
    if(exit_south > 0):
        text += get_dir_text("South", door_south, doors)
        has_exit = true
    if(exit_west > 0):
        text += get_dir_text("West", door_west, doors)
        has_exit = true
    if(exit_up > 0):
        text += get_dir_text("Up", door_up, doors)
        has_exit = true
    if(exit_down > 0):
        text += get_dir_text("Down", door_down, doors)
        has_exit = true
    if(!has_exit):
        text += " None"
    return text

func get_dir_text(dir: String, door: int, doors: Dictionary) -> String:
    if(door > 0):
        return "[color=%s] %s[/color]" % ["#f00" if doors[door].closed else "#0f0", dir]
    else:
        return " %s" % dir

func print_complete(room_config: RoomConfig) -> String:
    var text = "[color=#ff3300][b]%s[/b][/color]\n    %s\n" % [name, description]
    text += print_exits(room_config)
    return text
