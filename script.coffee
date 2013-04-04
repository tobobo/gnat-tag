$ ->
	console.log 'script.coffee'	

	window.requestAnimationFrame =
		window.requestAnimationFrame or 
		window.mozRequestAnimationFrame or
    window.webkitRequestAnimationFrame or
    window.msRequestAnimationFrame;

	theGame = new tag()

	window.step = () ->
		theGame.draw()
		window.requestAnimationFrame(window.step)
	
	window.requestAnimationFrame(window.step)