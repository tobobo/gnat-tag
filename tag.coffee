tag = () ->



	this.display = new display 1024, 768
	this.ctx = this.display.ctx

	this.agents = []

	for i in [0..1000]
		this.agents.push new agent(
			Math.random()*this.display.width, 
			Math.random()*this.display.height,
			Math.random()*2*Math.PI,
			Math.random()*2
		)

	this.updateAgents = (agents, width, height) ->
		for a in this.agents
			a.update(agents, width, height)

	this.drawAgents = () ->
		for p in this.agents
			p.draw(this.ctx)

	this.draw = () ->
		this.display.clear()
		this.updateAgents(this.agents, this.display.width, this.display.height)
		this.drawAgents()
		this.display.draw()

	this