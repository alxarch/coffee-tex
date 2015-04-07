TexError = require "../error"
Scope = require "../scope"
styles = require "./mathmode/styles"
handlers = require "./mathmode/handlers"
tokens = require "../tokens"
{ALIGNMENT_TAB, ESCAPE_CHARACTER, COMMENT, SUBSCRIPT, SUPERSCRIPT, BEGIN_GROUP, END_GROUP, SPACE, EOL, IGNORE} = tokens.$categories

class MathMode
	module.exports = @

	@handlers = handlers

	constructor: (@scope, display) ->
		# On the root scope of this mode we stop propagation
		@scope.$on "token", (event) -> event.stopPropagation()
		@scope.$handlers = MathMode.handlers.$new()
		@scope.$mode = @
		if display
			@scope.style = styles.D
		else
			@scope.style = styles.T
		return

	handleCommand: (name, scope) ->
		event = scope.$emit "command", name
		return if event.defaultPrevented
		if scope.$macros[name]
			scope.$macros.$expand name, scope
		handler = scope.$handlers[name]
		args = [scope]
		if handler instanceof Array
			handler = handler[0]
			args = args.concat handler[1..]
		if typeof handler is "string"
			handler = scope.$handlers[handler]
		unless typeof handler is "function"
			throw new TexError "Unhandled command #{name}", scope
		handler.apply null, args
		return

	handleScript: (scope, category) ->
		base = scope.$$tail
		base ?= scope.$new()
		if base[category]
			throw new TexError "Double #{category}", base

		s = base[category] = scope.$new()

		scope.$$tail = base
		base.$$next = null
		s.$$prev = null
		# Set style to current's style script style
		s.style = scope.style.script
		scope.$parser.currentScope = s
		cancel = s.$on "token", (event, token) ->
			# Set targetScope to superscript's parent if superscript
			# already has a child scope
			if event.targetScope is s and s.$head?
				event.targetScope = scope.$target.currentScope = scope
				cancel()
			return
		return

	handleToken: (token, scope) ->
		switch token.category
			when ESCAPE_CHARACTER
				scope.$parser.readName (name) => @handleCommand name, scope
			when COMMENT
				scope.$parser.skipLine()
			when SPACE, IGNORE, EOL
				return
			when LETTER, OTHER
				@handleCommand token.value, scope
			when BEGIN_GROUP
				scope.$parser.currentScope = scope.$new()
			when END_GROUP
				$parser.currentScope = scope.$parent
			when SUPERSCRIPT, SUBSCRIPT
				@handleScript scope, token.category
			when MATH_SHIFT, PARAM, ACTIVE, ALIGNMENT_TAB
				throw new Error "Unimplemented"
			else
				@handleCommand token.value, scope
		return
