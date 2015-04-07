module.exports = delimiters = {}
{assign} = require "../helpers"

defaults = {}
delimiters.$makeHanlder = makeHanlder = (code, options={}) ->
	if code.length is 4
		code = parseInt code, 16
	else
		code = code.codePointAt 0

	opt = assign {}, defaults, options
	(scope) ->
		del = scope.$new()
		del.value = code
		del.type = "delimiter"

data =
	'('        : ['(']
	')'        : [')']
	'['        : ['[']
	']'        : [']']
	'<'        : ['27E8']
	'>'        : ['27E9']
	lt         : ['27E8']
	gt         : ['27E9']
	'/'        : ['/']
	'|'        : ['|', {texClass: TEXCLASS.ORD}]
	'.'        : ['']
	'\\'       : ['\\']
	lmoustache : ['23B0'] #non-standard
	rmoustache : ['23B1'] #non-standard
	lgroup     : ['27EE'] #non-standard
	rgroup     : ['27EF'] #non-standard
	arrowvert  : ['23D0']
	Arrowvert  : ['2016']
	bracevert  : ['23AA'] #non-standard
	Vert       : ['2225', {texClass: TEXCLASS.ORD}]
	'|'        : ['2225', {texClass: TEXCLASS.ORD}]
	vert       : ['|', {texClass: TEXCLASS.ORD}]
	uparrow    : ['2191']
	downarrow  : ['2193']
	updownarrow: ['2195']
	Uparrow    : ['21D1']
	Downarrow  : ['21D3']
	Updownarrow: ['21D5']
	backslash  : ['\\']
	rangle     : ['27E9']
	langle     : ['27E8']
	rbrace     : ['}']
	lbrace     : ['{']
	'}'        : ['}']
	'{'        : ['{']
	rceil      : ['2309']
	lceil      : ['2308']
	rfloor     : ['230B']
	lfloor     : ['230A']
	lbrack     : ['[']
	rbrack     : [']']

for own name, args in data
	delimiters[name] = makeHanlder args
return