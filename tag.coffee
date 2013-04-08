
class Tag
	constructor: (@width, @height) ->
		@display = new Disp @width, @height
		@ctx = this.display.ctx

		window.debug = false

		@agents = []
		@bases = []

		thisTag = @

		for i in [0..500]
			agentX = Math.random() * @display.width
			agentY = Math.random() * @display.height
			agentHeading = Math.random() * 2 * Math.PI
			agentSpeed = Math.random() * 5
			@agents.push new
				Agent [agentX, agentY], agentHeading, agentSpeed, Agent.STATES.BASE

		@basePositions = [[0.25, 0.25], [0.75, 0.25], [0.25, 0.75], [0.75, 0.75]]

		for b in @basePositions
			@bases.push new Base [@width * b[0], @height * b[1]]

		window.requestAnimationFrame =
			window.requestAnimationFrame or 
			window.mozRequestAnimationFrame or
			window.webkitRequestAnimationFrame or
			window.msRequestAnimationFrame

		if window.debug
			($ window).bind 'keydown', (e) ->
				if e.keyCode == 32 then thisTag.step()
				false

		@step = ->
			thisTag.draw()
			unless window.debug
				window.requestAnimationFrame thisTag.step

	anim: ->
		@step()

	updateAgents: (agents, width, height) ->
		for a in @agents
			a.update @

	drawAgents: ->
		for a in @agents
			a.draw this.ctx

	drawBases: ->
		for b in @bases
			b.draw this.ctx

	draw: ->
		@display.clear()
		@updateAgents @agents, @display.width, @display.height
		@drawBases()
		@drawAgents()
		@display.draw()

