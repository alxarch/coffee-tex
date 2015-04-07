Scope = require "../scope"
MathMode = require "./modes/math"
{assign} = require "../helpers"
tokens = require "./tokens"
{OTHER, LETTER, EOL} = tokens.$categories

class Parser
	module.exports = @
	@scope = root = new Scope()
	@scope.$tokens = tokens
	@scope.$mode = new MathMode @scope

	constructor: () ->
		@scope = @currentScope = root.$new()
		@scope.$parser = @
		@line = 0
	
	parseLine: (line) ->
		'''
		Feed a line to the token lions
		'''
		@line++
		end = line.length
		pos = 0
		while pos < end
			# utf-8 weirdness
			c = line[pos]
			n = c.charCodeAt 0
			if n >= 0xD800 and n < 0xDC00
				cc = line[pos + 1]
				unless cc is undefined
					pos += 2
					c += cc

			token =
				value: c
				category: @currentScope.tokens[c] or OTHER
			event = @currentScope.$emit "token", token
			unless event.defaultPrevented
				@currentScope.$mode.handleToken token
		return

	skipLine: () ->
		cancel = @currentScope.$on "token", (event, token) ->
			if token.category is EOL
				cancel()
			else
				event.preventDefault()
				event.stopPropagation()

	readName: (callback) ->
		name = ""
		cancel = @currentScope.$on "token", (event, token) ->
			if token.category is LETTER
				event.preventDefault()
				event.stopPropagation()
				name += token.value
			else
				cancel()
				callback name
			return
