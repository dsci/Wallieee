###
Models
###
class WallPost extends Backbone.Model
	
###
Views
###

	
class WallPostView extends Backbone.View	
	#template: Handlebars.compile($("#postList").html())
	template: $('#postList')
		
	initialize: ->
		@model.bind('change', @render) 
		@render() 
	
	render: =>
		@addPost(@model)
		@
	addPost: (model)->
		$('#postList').append("<li>" + model.get('text') + "</li>")
###
Collections
###
class WallPosts extends Backbone.Collection
	model	:	WallPost
	url		:	'/posts'
	 
window.WallPost		= WallPost
window.WallPostView 	= WallPostView	
window.WallPosts		= new WallPosts()


jQuery ->
	class AppView extends Backbone.View
		el: '.posts'
		events:
			"click .lari": "submitPost"
		initialize: ->
			#_.bindAll(@, 'render')
			console.log($('#messageForm'))
			@collection = window.WallPosts 
			@collection.bind('all', @render)
			@collection.fetch()
			@render()
		
		render: =>
			console.log("I did something!")
			console.log($(@el))
			console.log(post.get('text')) for post in @collection.models
			new WallPostView(model: post) for post in @collection.models
		
		submitPost: ()=>
			console.log("submitted somethin")	
			return false;
	window.App			= AppView
	new App()