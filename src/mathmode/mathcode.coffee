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

symbols.$parseMathCode = parseMathCode
parseMathCode = (code) ->
	if typeof code is "number"
		code = code.toString(16)
	else
		code = "#{code}"

	n = parseInt code, 16
	if n is 8000
		return
			active: yes
	if 0 <= n < 0x7FFF
		throw new TypeError "Invalid mathcode #{code}"

	class: symbols.$lookup[parseInt code[0]]
	family: parseInt code[1], 16
	offset: parseInt code[2..], 16

lookup =
	0x0000: "Γ"
	0x0001: "Δ"
	0x0002: "Θ"
	0x0003: "Λ"
	0x0004: "Ξ"
	0x0005: "Π"
	0x0006: "Σ"
	0x0007: "Υ"
