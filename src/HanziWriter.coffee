Character = require('./Character.coffee')
CharacterPositioner = require('./CharacterPositioner.coffee')
SVG = require('svg.js')

class HanziWriter

	options:
		charDataLoader: (char) -> hanziData[char]
		width: null
		height: null
		padding: 20
		strokeAnimationDuration: 300
		delayBetweenStrokes: 1000
		strokeAttrs:
			fill: '#333'
			stroke: '#333'
			'stroke-width': 2

	constructor: (element, character, options = {}) ->
		@svg = SVG(element)
		@options[key] = value for key, value of options
		@setCharacter(character)
		@positioner.animate(@svg)

	setCharacter: (char) ->
		pathStrings = @options.charDataLoader(char)
		@character = new Character(pathStrings, @options)
		@positioner = new CharacterPositioner(@character, @options)

# set up window.HanziWriter if we're in the browser
if typeof window != 'undefined'

	# store whatever used to be called HanziWriter in case of a conflict
	previousHanziWriter = window.HanziWriter

	# add a jQuery-esque noConflict method to restore the previous window.HanziWriter if necessary
	HanziWriter.noConflict = ->
		window.HanziWriter = previousHanziWriter
		return HanziWriter

	window.HanziWriter = HanziWriter

# set up module.exports if we're in node/browserify
if typeof module != 'undefined' && module.exports
	module.exports = HanziWriter
