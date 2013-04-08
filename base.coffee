class Base
	constructor: (@loc) ->

	draw: (ctx) ->
		ctx.lineWidth = 2
		ctx.beginPath()
		ctx.arc(@loc..., 30, 0, 2 * Math.PI, false)
		ctx.fillStyle = 'rgb(41,212,255)';
		ctx.fill()