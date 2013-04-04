agent = (x, y, heading, speed) ->
	this.x = x
	this.y = y
	this.heading = heading
	this.speed = speed;

	this.maxSpeed = 2;
	this.minSpeed = 0;

	this.update = (agents, width, height) ->
		this.x += Math.cos(this.heading)*this.speed
		this.y += Math.sin(this.heading)*this.speed
		
		randomVariance = (variance) -> (Math.random() - 0.5)*(variance)
		this.heading = this.heading += randomVariance(0.5)
		this.speed = this.speed += randomVariance(0.25)

		if this.speed > this.maxSpeed then this.speed = this.maxSpeed
			else if this.speed < this.minSpeed then this.speed = this.minSpeed


	this.draw = (ctx) ->
		ctx.lineWidth = 2
		ctx.beginPath();
		ctx.arc(this.x, this.y, 2, 0, 2 * Math.PI, false)
		ctx.fill()

	this
