{assign} = require "./helpers"
ESCAPE_CHARACTER = 'escape_character'
BEGIN_GROUP =      'begin_group'
END_GROUP =        'end_group'
MATH_SHIFT =       'math_shift'
ALIGNMENT_TAB =    'alignment_tab'
EOL =              'eol'
PARAMETER =        'parameter'
SUPERSCRIPT =      'superscript'
SUBSCRIPT =        'subscript'
IGNORE =           'ignore'
SPACE =            'space'
LETTER =           'letter'
OTHER =            'other'
ACTIVE =           'active'
COMMENT =          'comment'
INVALID =          'invalid'
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
