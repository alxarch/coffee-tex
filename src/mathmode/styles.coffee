sizes = require "./sizes"
Style = require "../style"

module.exports = styles = {}


D = styles.D = styles.display = new Style "display", sizes.display
S = styles.S = styles.script = = new Style "script", sizes.script
T = styles.T = styles.text = new Style "text", sizes.text
SS = styles.SS = styles.scriptscript = new Style "scriptscript", sizes.scriptscript

d = styles.d = styles._display = new Style "display", sizes.display, yes
s = styles.s = styles._script = new Style "script", sizes.script, yes
t = styles.t = styles._text = new Style "text", sizes.text, yes
ss = styles.ss = styles._scriptscript = new Style "scriptscript", sizes.scriptscript, yes

D.cramped = d
d.uncramped = D

T.cramped = t
t.uncramped= T

S.cramped = s
s.uncramped= S

SS.cramped = ss
ss.uncramped = SS

D.script = T.script = S
d.script = t.script = s
S.script = SS.script = SS
s.script = ss.script = ss

D.numerator = T
D.denominator = t

d.numerator = t
d.denominator = t

T.numerator = S
T.denominator = s

t.numerator = s
t.denominator = s

S.numerator = SS.numerator = SS
S.denominator = SS.denominator = ss

s.numerator = ss.numerator = ss
s.denominator = ss.denominator = ss
