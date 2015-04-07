class Style
	module.exports = @
	constructor: (@name, @cramped, @size) ->
	toString: -> "style: #{@name}#{if @cramped then ' (cramped)' else ''}"
