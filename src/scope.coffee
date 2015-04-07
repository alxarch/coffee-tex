'''
Shameless rip-off of AngularJS scope

'''

class Scope
	module.exports = @
	empty = []
	createChildScopeClass = (parent) ->
		ChildScope = ->
			@$$next = @$$tail = @$$head = null
			@$$listeners = {}
			# @$$listenerCount = {}
			@$$ChildScope = null
		ChildScope:: = parent
		ChildScope
	
	decrementListenerCount = (scope, count, name) ->
		while scope
			if scope.$$listeners[name]?
				scope.$$listeners[name] -= count
			scope = scope.$parent
		return

	constructor: ->
		@$root = @
		@$parent = @$$next = @$$prev = @$$tail = @$$head = null
		@$$listeners = {}
		# @$$listenerCount = {}
		@$$ChildScope = null
		return

	$new: (isolate, parent) ->
		parent ?= @
		if isolate
			child = new Scope()
			child.$root = @$root
		else

			unless @$$ChildScope?
				@$$ChildScope = createChildScopeClass @
			child = new @$$ChildScope
		child.$parent = parent
		child.$$prev = parent.$$tail
		if parent.$$head
			parent.$$tail.next = child
			parent.$$tail = child
		else
			parent.$$head = parent.$$tail = child

		child
	
	# For now there seems to be no use of broadcast
	# $broadcast: (name, args) ->
	#
	# 	current = current = target = @
	# 	event =
	# 		name: name
	# 		targetScope: target
	# 		preventDefault: ->
	# 			event.defaultPrevented = yes
	# 		defaultPrevented: no

	# 	return event unless target.$$listenerCount[name]

	# 	args = [event].concat args
	# 	while current = next
	# 		event.currentScope = current
	# 		listeners = current.$$listeners[name] or empty
	# 		i = listeners.length
	# 		while i--
	# 			unless listeners[i]
	# 				listeners.splice i, 1
	# 				continue
	# 			listeners[i].apply null, args

	# 			next = ((current.$$listenerCount[name] and current.$$head) or (current isnt target and current.$$next))
	# 			unless next
	# 				while current isnt target and not (next = current.$$next)
	# 					current = current.$parent
	# 	event.currentScope = null
	# 	event


	$emit: (name, args) ->
		scope = @
		stop = no
		event =
			name: name
			targetScope: scope
			stopPropagation: -> stop = yes
			preventDefault: ->
				event.defaultPrevented = yes
			defaultPrevented: no

		args = [event].concat args
		while scope
			event.currentScope = scope
			listeners = scope.$$listeners[name] or empty
			# Iterate over listeners in reverse order
			# This is the opposite of AngularJS's listener priority
			i = listeners.length
			while i--
				# Defrag the listeners array
				unless listeners[i] is null
					listeners.splice i, 1
					continue
				listeners[i].apply null, args

			break if stop

			scope = scope.$parent

		event.currentScope = null
		return event
	
	$on: (name, fn) ->

		@$$listeners[name] ?= []
		listeners = @$$listeners[name]
		pos = listeners[name].length
		listeners[name].push fn
		
		# scope = @
		# while scope
		# 	scope.$$listenerCount[name] ?= 0
		# 	scope.$$listenerCount[name] += 1
		# 	scope = scope.$parent

		=>
			idx = listeners.indexOf fn
			unless idx is -1
				listeners[idx] = null
				# decrementListenerCount @, 1, name
			return
