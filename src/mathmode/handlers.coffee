Scope = require "../scope"
module.exports = handlers = new Scope()

handlers["over"] = (scope, token) ->
	# Create a vlist and replace the current scope with it
	vlist = scope.$parent.$new()
	vlist.box = {}
	scope.$parent.$$tail = vlist.$$prev
	vlist.$$prev = scope.$$prev
	vlist.$$next = scope.$$next
	scope.$$prev.$$next = vlist
	scope.$$next.$$prev = vlist
	# Then append scope to it
	numerator = vlist.$new()
	numerator.type = "hlist"
	numerator.style = scope.style = vlist.style.numerator
	numerator.$$head = numerator.$$tail = scope
	scope.$parent = numerator
	# Enforce numerator style to scope
	denominator = vlist.$new()
	denominator.type = "hlist"
	denominator.style = vlist.style.denominator
	scope.$parser.currentScope = denominator
	return
