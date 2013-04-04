disp = (width, height) ->

	this.width = parseInt width
	this.height = parseInt height

	this.$body = $ 'body'


	this.$body.append (
		this.$canvas = 
			$('<canvas>').attr('width', width).attr('height', height)
	)

	this.canvas = this.$canvas.get 0

	this.ctx = this.canvas.getContext '2d'
	this.ctx.lineWidth = 4

	this.clear =() ->
		this.ctx.clearRect 0, 0, this.width, this.height

	this.draw = () ->
		this.drawBorder(this.ctx)

	this.drawBorder = () ->
		this.ctx.strokeRect 0, 0, width, height

	this
