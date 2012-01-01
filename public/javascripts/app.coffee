jQuery ->
	###
	Models
	###
	class WallPost extends Backbone.Model
	
	window.WallPost		= WallPost
	
	###
	Collections
	###
	class WallPosts extends Backbone.Collection
		model	:	WallPost
		url		:	'/posts'
	
	window.WallPosts = new WallPosts()
	
	###
	Views
	###
	class WallPostView extends Backbone.View	
		#template: Handlebars.compile($("#postList").html())
		template: _.template($('#postList').html())
		tagName:  "li"
		className: "messageRow"
		
		initialize: ->
			@model.bind('change', @render) 
			@render() 
	
		render: =>
			$(@el).html(@template(@model.toJSON()));
			@setText()
			@
			
		setText: =>
			text = @model.get('text')
			@$('.walltext').text(text);
			
	window.WallPostView 	= WallPostView	
	
	class AppView extends Backbone.View
		el: '.container'
		countTemplate: _.template($('#wallpostCount').html())
		events:
			"submit #messageForm": "submitPost"
			
		initialize: ->
			#_.bindAll(@, 'render')
			@collection = window.WallPosts 
			@collection.bind('all', @render, @)
			@collection.bind('add', @addOne,@)
			@collection.fetch()
			@render()
		
		render: =>
			$('#message').focus()
			variables = 
				total: @collection.length
			$('#count').html(@countTemplate(variables))
			$("#recents #recents-list").children().remove()
			for post in @collection.models
				view = new WallPostView(model: post)
				$("#recents #recents-list").prepend(view.render().el)  
			#return
		
		submitPost: ()=>
			if $('#message').val() is ""
				$('#errorAlert').show()
			else
				$('#errorAlert').hide()
				post = @collection.create({text: $('#message').val()})
				@resetInput()
			return false;
			
		resetInput: ->
			$('#message').val("")
			$('#message').focus()
		addOne: (post) =>
			view = new WallPostView(model: post)
			$("#recents #recents-list").prepend(view.render().el)
	
	window.App			= AppView
	
	# Run a new App.  
	new App()