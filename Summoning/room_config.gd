extends Object

class_name RoomConfig

var rooms: Dictionary = {}
var doors: Dictionary = {}

func _init() -> void:
    rooms[1] = ( Room.new()
        .set_name("Dark Cellar")
        .set_description("You stand in a dark room. Seems like a type of cellar. \
There are drawings on the floor, and a lot of scattered objects. Something happened here. \
The air smells like burnt candles and blood. Something serious happened in this place.")
    )

    rooms[2] = ( Room.new()
        .set_name("Workshop")
        .set_description("A small room containing many tools. There's a small lamp \
    that allows you to see the items contained in here. There's a tool cabinet at the \
    farthest corner of the room.")
    )

    rooms[3] = ( Room.new()
        .set_name("Wardrobe")
        .set_description("Sample Description ")
    )

    rooms[4] = ( Room.new()
        .set_name("Living Room")
        .set_description("Sample Description ")
    )
    rooms[5] = ( Room.new()
        .set_name("Living Room")
        .set_description("Sample Description ")
    )

    rooms[6] = ( Room.new()
        .set_name("Living Room")
        .set_description("Sample Description ")
    )

    rooms[7] = ( Room.new()
        .set_name("Living Room")
        .set_description("Sample Description ")
    )

    rooms[8] = ( Room.new()
        .set_name("Living Room")
        .set_description("Sample Description ")
    )

    rooms[9] = ( Room.new()
        .set_name("Living Room")
        .set_description("Sample Description ")
    )

    doors[1] = ( Door.new("a wooden cabinetwoo door", true, "") )

    make_passage("e", 1, 2, 1)

    make_passage("w", 1, 3, 0)

    make_passage("n", 1, 4, 0)

func make_passage(dir: String, from: int, to: int, door: int):
    match(dir):
        "n":
            rooms[from].set_exit_north(to, door)
            rooms[to].set_exit_south(from, door)
        "s":
            rooms[from].set_exit_south(to, door)
            rooms[to].set_exit_north(from, door)
        "e":
            rooms[from].set_exit_east(to, door)
            rooms[to].set_exit_west(from, door)
        "w":
            rooms[from].set_exit_west(to, door)
            rooms[to].set_exit_east(from, door)
