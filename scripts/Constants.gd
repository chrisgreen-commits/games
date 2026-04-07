# Constants.gd - Game Configuration
extends Node

# Screen Configuration
const SCREEN_WIDTH = 1920
const SCREEN_HEIGHT = 1080

# Game Settings
const STARTING_LIVES = 1
const BEANS_PER_LIFE = 50
const NINJA_KICK_DAMAGE = 1
const NINJA_SWIPES_TO_DEFEAT = 3
const NINJA_BALLS_TO_DEFEAT = 2
const TOTAL_NINJAS_ROOM4 = 100
const BALL_RELOAD_TIME = 5.0

# Item Enum
enum ITEMS {
	TORCH,
	PLAYING_CARD,
	VASE,
	BOOK_1,
	BOOK_2,
	BOOK_3,
	GLASSES,
	MUG,
	FLIP_PHONE,
	CANDLESTICK,
	NOTEPAD,
	WRIST_WATCH,
	POOL_CUE,
	POOL_BALLS,
	COFFEE_BEAN
}

# Item Names Dictionary
const ITEM_NAMES = {
	ITEMS.TORCH: "Torch",
	ITEMS.PLAYING_CARD: "Playing Card",
	ITEMS.VASE: "Vase",
	ITEMS.BOOK_1: "Book (Excalibur Lore)",
	ITEMS.BOOK_2: "Book (Ancient Texts)",
	ITEMS.BOOK_3: "Book (Detective's Journal)",
	ITEMS.GLASSES: "Glasses",
	ITEMS.MUG: "Coffee Mug",
	ITEMS.FLIP_PHONE: "Flip Phone",
	ITEMS.CANDLESTICK: "Candlestick",
	ITEMS.NOTEPAD: "Notepad",
	ITEMS.WRIST_WATCH: "Wrist Watch",
	ITEMS.POOL_CUE: "Pool Cue",
	ITEMS.POOL_BALLS: "Pool Balls",
	ITEMS.COFFEE_BEAN: "Coffee Bean"
}