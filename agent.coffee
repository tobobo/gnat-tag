class Agent

	@maxVel = 3;
	@minVel = 0.5;

	@evalHeading = (heading) ->
		heading - Math.floor (heading / 2*Math.PI) * heading

	constructor: (@x, @y, @heading, @vel) ->
		@x = x
		@y = y

		@vel = vel;

		@maxVel = 3;
		@minVel = 0.5;

		@heading = Agent.evalHeading heading

	update: (agents, width, height) ->
		@x += Math.cos(@heading)*@vel
		@y += Math.sin(@heading)*@vel
		
		randomVariance = (variance) -> (Math.random() - 0.5)*(2*variance)
		@heading = @heading += randomVariance 0.25
		@vel = @vel += randomVariance 0.05

		if @vel > @maxVel then @vel = Agent.maxVel
		else if @vel < @minVel then @vel = Agent.minVel

	changeHeading: (delta) ->
		@heading = Agent.evalHeading @heading + delta

	draw: (ctx) ->
		ctx.lineWidth = 2
		ctx.beginPath()
		ctx.arc(@x, @y, 2, 0, 2 * Math.PI, false)
		ctx.fill()
