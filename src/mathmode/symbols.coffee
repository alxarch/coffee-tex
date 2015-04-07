module.exports = symbols = {}

ORD = "ordinary"
LARGE = "largeop"
BIN = "binary"
REL = "relation"
OPEN = "open"
CLOSE = "close"
PUNCT = "punctuation"
VAR = "variable"

symbols.$classes = {ORD, LARGE, BIN, REL, OPEN, CLOSE, PUNCT, VAR}
symbols.$mulipliers =
	ordinary: 0
	largeop: 1
	binary: 2
	relation: 3
	open: 4
	close: 5
	punctuation: 6
	variable: 7

symbols.$lookup = [ORD, LARGE, BIN, REL, OPEN, CLOSE, PUNCT, VAR]

