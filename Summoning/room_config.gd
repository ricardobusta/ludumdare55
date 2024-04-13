extends Object

class_name RoomConfig

var rooms: Dictionary = {}

func _init() -> void:
    rooms[1] = ( Room.new()
        .set_name("Dark Cellar")
        .set_description("You stand in a dark room. Seems like a type of cellar. \
There are drawings on the floor. But it's too dark to see.")
        .set_exits(2, 0, 0, 0)
    )
    rooms[2] = ( Room.new()
        .set_name("Test 2")
        .set_description("Sample Description of room 2")
        .set_exits(1, 0, 0, 0)
    )
