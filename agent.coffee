window.log = (what) ->
	if window.debug then console.log arguments...


class Agent

	#states
	@STATES = { BASE: 1 }

	@maxVel = 3;
	@minVel = 0.5;
	@target = [null, null]

	@evalHeading = (heading) ->
		heading -= Math.floor (heading / (2*Math.PI)) * heading
		if heading < 0 then 2*Math.PI + heading else heading

	@dHeading = (h1, h2) ->
		del = h2 - h1
		if del < - Math.PI then 2*Math.Pi + del else
		if del < Math.Pi then del else
			2*Math.Pi - del

	@planeAngle = (p1, p2) -> 
		vertDist = p2[1] - p1[1]
		horizDist = p2[0] - p1[0]
		window.log 'vertDist: ', vertDist
		window.log 'horizDist: ', horizDist
		ratio = vertDist / horizDist
		window.log 'ratio: ', ratio
		atan = Math.atan ratio
		window.log 'atan: ', atan
		if vertDist > 0 
			if horizDist > 0 then Math.PI + atan
			else atan
		else
			if horizDist < 0 then atan
			else Math.PI + atan

	@planeDist = (p1, p2) -> Math.sqrt (Math.pow p2[1] - p1[1], 2) + (Math.pow p2[0] - p1[0], 2)

	@arrayMin = (arr) ->
		min = Infinity
		minIndex = -1
		for i in [0..arr.length] by 1
			if arr[i] < min
				min = arr[i]
				minIndex = i
		minIndex


	constructor: (@loc, heading, @vel, @state = Agent.STATES.BASE) ->
		@target = [null, null]
		@heading = Agent.evalHeading heading

	update: (game) ->
		thisAgent = @

		if @state == Agent.STATES.BASE
			distances = game.bases.map (b) ->
				Agent.planeDist thisAgent.loc, b.loc
			window.log 'distances: ', distances
			minDist = Agent.arrayMin distances
			@target = game.bases[minDist].loc
			window.log 'target: ', @target
			@heading = Agent.planeAngle @target, @loc
			window.log 'heading: ', @heading

		randomVariance = (variance) -> (Math.random() - 0.5)*(2*variance)

		@heading = @heading += randomVariance 0.25
		@vel = @vel += randomVariance 0.05

		if @vel > Agent.maxVel then @vel = Agent.maxVel
		else if @vel < Agent.minVel then @vel = Agent.minVel

		@loc[0] += Math.cos(@heading) * @vel
		@loc[1] += Math.sin(@heading) * @vel

	changeHeading: (delta) ->
		@heading = Agent.evalHeading @heading + delta

	draw: (ctx) ->
		ctx.lineWidth = 2
		ctx.beginPath()
		ctx.fillStyle = 'rgb(0,0,0)';
		ctx.arc(@loc..., 2, 0, 2 * Math.PI, false)
		ctx.fill()
