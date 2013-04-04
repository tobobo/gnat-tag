window.requestAnimationFrame =
window.requestAnimationFrame or 
window.mozRequestAnimationFrame or
window.webkitRequestAnimationFrame or
window.msRequestAnimationFrame

tag = () ->
	this.display = new disp 1024, 768
	this.ctx = this.display.ctx

	thisTag = this

	this.agents = []

	for i in [0..1000]
		agentX = Math.random()*this.display.width
		agentY = Math.random()*this.display.height
		agentHeading = Math.random()*2*Math.PI
		agentSpeed = Math.random()*5
		this.agents.push new
			agent agentX, agentY, agentHeading, agentSpeed

	this.anim = () ->
		window.requestAnimationFrame thisTag.step

	this.updateAgents = (agents, width, height) ->
		for a in this.agents
			a.update agents, width, height

	this.drawAgents = () ->
		for a in this.agents
			a.draw this.ctx

	this.draw = () ->
		this.display.clear()
		this.updateAgents this.agents, this.display.width, this.display.height
		this.drawAgents()
		this.display.draw()

	this.step = () ->
		thisTag.draw()
		window.requestAnimationFrame thisTag.step

	this