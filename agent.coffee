agent = (x, y, heading, vel) ->
	this.x = x
	this.y = y

	this.vel = vel;

	this.maxVel = 3;
	this.minVel = 0.5;

	this.evalHeading = (heading) ->
		heading - Math.floor (heading / 2*Math.PI) * heading

	this.heading = this.evalHeading heading

	this.update = (agents, width, height) ->
		this.x += Math.cos(this.heading)*this.vel
		this.y += Math.sin(this.heading)*this.vel
		
		randomVariance = (variance) -> (Math.random() - 0.5)*(2*variance)
		this.heading = this.heading += randomVariance 0.25
		this.vel = this.vel += randomVariance 0.05

		if this.vel > this.maxVel then this.vel = this.maxVel
		else if this.vel < this.minVel then this.vel = this.minVel

	this.changeHeading = (delta) ->
		this.heading = this.evalHeading (this.heading + delta)

	this.draw = (ctx) ->
		ctx.lineWidth = 2
		ctx.beginPath()
		ctx.arc(this.x, this.y, 2, 0, 2 * Math.PI, false)
		ctx.fill()

	this
