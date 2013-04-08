class Disp

	constructor: (@width, @height) ->

		@$body = $ 'body'

		@$body.append (
			@$canvas = 
				$('<canvas>').attr('width', width).attr('height', height)
		)

		@canvas = @$canvas.get 0

		@ctx = @canvas.getContext '2d'
		@ctx.lineWidth = 4

	clear:() ->
		@ctx.clearRect 0, 0, @width, @height

	draw: () ->
		@drawBorder @ctx

	drawBorder: () ->
		@ctx.strokeRect 0, 0, @width, @height

