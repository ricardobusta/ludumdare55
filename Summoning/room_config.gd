extends Object

class_name RoomConfig

var rooms: Dictionary = {}

func _init() -> void:
    rooms[1] = ( Room.new()
        .set_name("Dark Cellar")
        .set_description("You stand in a dark room. Seems like a type of cellar. \
There are drawings on the floor. But it's too dark to see.")
    )

    rooms[2] = ( Room.new()
        .set_name("Tools Cabinet")
        .set_description("Sample Description ")
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

    make_passage("e", 1, 2)

func make_passage(dir: String, from: int, to: int):
    match(dir):
        "n":
            rooms[from].set_exit_north(to)
            rooms[to].set_exit_south(from)
        "s":
            rooms[from].set_exit_south(to)
            rooms[to].set_exit_north(from)
        "e":
            rooms[from].set_exit_east(to)
            rooms[to].set_exit_west(from)
        "w":
            rooms[from].set_exit_west(to)
            rooms[to].set_exit_east(from)
