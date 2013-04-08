window.log = (what) ->
	if window.debug then console.log arguments...


class Agent

	#agent states
	@STATES = { BASE: 1 }

	@maxVel = 3
	@minVel = 0.5
	@maxAcc = 0.5


	#The distance at which the agent will start slowing before a still object
	@dSlow = 50

	@clip = (x, min, max = null) ->
		if max == null
			max = min
			min = -max
		if x < min then min else if x > max then max else x


	@evalHeading = (heading) ->
		heading -= Math.floor (heading / (2*Math.PI)) * heading
		if heading < 0 then 2*Math.PI + heading else heading

	@dHeading = (h1, h2) ->
		del = h2 - h1
		if del < - Math.PI then 2*Math.Pi + del else
		if del < Math.Pi then del else
			2*Math.PI - del

	@planeAngle = (p1, p2) -> 
		vertDist = p2[1] - p1[1]
		horizDist = p2[0] - p1[0]
		window.log 'vertDist: ', vertDist
		window.log 'horizDist: ', horizDist
		ratio = vertDist / horizDist
		atan = Math.atan ratio
		window.log 'atan: ', atan
		if vertDist > 0 
			if horizDist > 0 then Math.PI + atan
			else atan
		else
			if horizDist < 0 then atan
			else Math.PI + atan

	@planeDist = (p1, p2) -> Math.sqrt (Math.pow p2[1] - p1[1], 2) + (Math.pow p2[0] - p1[0], 2)

	@arrayMin = (arr, ignore = -1) ->
		min = Infinity
		minIndex = -1
		for i in [0..arr.length] by 1
			if (ignore == -1 or i != ignore) and arr[i] < min
				min = arr[i]
				minIndex = i
		minIndex

	@randomVariance = (variance) -> (Math.random() - 0.5)*(2*variance)


	constructor: (@loc, heading, @vel, @state = Agent.STATES.BASE) ->
		@target = [null, null]
		@heading = Agent.evalHeading heading
		@tBase = 0
		@currBase = -1
		@prevBase = -1

	update: (game) ->
		thisAgent = @

		if @state == Agent.STATES.BASE
			if @currBase > -1
				rand = Math.random()
				window.log 'rand: ', rand
				window.log 'currBase', game.bases[@currBase]
				ratio = Agent.clip @tBase / game.bases[@currBase].tMax, 0, 1
				window.log 'ratio: ', ratio

				if rand < Math.pow ratio, 2
					@prevBase = @currBase

			distances = game.bases.map (b) ->
				Agent.planeDist thisAgent.loc, b.loc

			window.log 'distances: ', distances
			minDistIndex = Agent.arrayMin distances, @prevBase
			@currBase = minDistIndex
			tDist = distances[minDistIndex]
			@target = game.bases[minDistIndex].loc
			window.log 'target: ', @target
			window.log 'minDistIndex: ', minDistIndex
			window.log 'dSafe: ', game.bases[@currBase].dSafe
			if tDist > game.bases[@currBase].dSafe
				@tBase = 0
				@heading = Agent.planeAngle @target, @loc
				window.log 'heading: ', @heading
				if tDist < Agent.dSlow
					@vel += Agent.clip @vel * (Math.pow (tDist / Agent.dSlow), 2) - @vel, Agent.maxAcc
				else @vel += Agent.clip Agent.maxVel - @vel, Agent.maxAcc
			else 
				@vel += Agent.clip 0 - @vel, Agent.maxAcc
				@tBase += 1
				window.log 'tbase', @tBase

		@heading = @heading += Agent.randomVariance 0.25
		@vel = @vel += Agent.randomVariance 0.05

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
