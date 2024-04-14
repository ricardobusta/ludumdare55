extends Object

class_name Door

var closed: bool = false
var key: String = ""
var description: String = "a door"

func _init(desc: String, is_closed: bool, requires_key: String):
    closed = is_closed
    key = requires_key
    description = desc
