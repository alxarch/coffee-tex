{assign} = require "./helpers"
ESCAPE_CHARACTER = 0
BEGIN_GROUP =      1
END_GROUP =        2
MATH_SHIFT =       3
ALIGNMENT_TAB =    4
EOL =              5
PARAMETER =        6
SUPERSCRIPT =      7
SUBSCRIPT =        8
IGNORE =           9
SPACE =            10
LETTER =           11
OTHER =            12
ACTIVE =           13
COMMENT =          14
INVALID =          15
module.exports = tokens = new Scope()
tokens.$categories = {
	ESCAPE_CHARACTER
	BEGIN_GROUP
	END_GROUP
	MATH_SHIFT 
	ALIGNMENT_TAB 
	EOL 
	PARAMETER 
	SUPERSCRIPT 
	SUBSCRIPT 
	IGNORE 
	SPACE 
	LETTER 
	OTHER 
	ACTIVE 
	COMMENT 
	INVALID 
}
assign tokens, do ->
	map = 
		"\\" : ESCAPE_CHARACTER
		"{": BEGIN_GROUP
		"}": END_GROUP
		"$": MATH_SHIFT
		"&": ALIGNMENT_TAB
		"\n": EOL
		"#": PARAMETER
		"%": COMMENT
		"^": SUPERSCRIPT
		"_": SUBSCRIPT
		"\0": IGNORE
		" ": SPACE
		"\t": SPACE
		"\r": SPACE
		"~": ACTIVE
		"\127": DELETE
		"'": PRIME
	for c in "abcdefghijklmnopqrstuvxyz"
		map[c] = LETTER
		map[c.toUpperCase()] = LETTER
	map
