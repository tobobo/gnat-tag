class Tag
	constructor: ->
		@display = new Disp 1024, 768
		@ctx = this.display.ctx

		@agents = []
		thisTag = @

		for i in [0..500]
			agentX = Math.random() * @display.width
			agentY = Math.random() * @display.height
			agentHeading = Math.random() * 2 * Math.PI
			agentSpeed = Math.random() * 5
			@agents.push new
				Agent agentX, agentY, agentHeading, agentSpeed

		window.requestAnimationFrame =
			window.requestAnimationFrame or 
			window.mozRequestAnimationFrame or
			window.webkitRequestAnimationFrame or
			window.msRequestAnimationFrame

		@step = ->
			thisTag.draw()
			window.requestAnimationFrame thisTag.step
			thisTag

	anim: ->
		@step()

	updateAgents: (agents, width, height) ->
		for a in @agents
			a.update agents, width, height

	drawAgents: ->
		for a in @agents
			a.draw this.ctx

	draw: ->
		@display.clear()
		@updateAgents @agents, @display.width, @display.height
		@drawAgents()
		@display.draw()

