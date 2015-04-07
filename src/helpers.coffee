asssign = (base, others...) ->
	return base unless base? and typeof base is "object"
	for o in others when o? and typeof o is "object" 
		for own key, value of o
			base[key] = value
	base
module.exports = helpers = {assign}
