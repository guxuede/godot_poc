# Boilerplate class to get full autocompletion and type checks for the `player` when coding the player's states.
# Without this, we have to run the game to see typos and other errors the compiler could otherwise catch while scripting.
class_name PlayerState extends State

const IDLE = "Idle"
const WALK = "Walk"
const SLASH = "Slash"
const SLASH1 = "Slash1"
const SPELLCAST = "Spellcast"
const SHOT = "Shot"
const WATER = "Water"

var player: Player


func _ready() -> void:
	await owner.ready
	player = owner
