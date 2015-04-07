class Size
	module.exports = @
	toString: -> "size: #{@name}"

class TextSize extends Size
	Size.text = @
	name: "text"

class DisplaySize extends Size
	Size.display = @
	name: "display"

class ScriptSize extends Size
	Size.script = @
	name: "script"

class ScriptScriptSize extends Size
	Size.scriptscript = @
	name: "scriptscript"
