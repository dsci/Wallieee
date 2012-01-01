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
		#template: '#postList'
		template: _.template($('#postList').html())
		#el: '#recents ul'	
		tagName:  "li"
		className: "messageRow"
		
		initialize: ->
			@model.bind('change', @render) 
			@render() 
	
		render: =>
			#@addPost(@model)
			#template = _.template($(@template).html(),{});
			#$(@el).html(template)
			#template = _.template($(@template).html())
			$(@el).html(@template(@model.toJSON()));
			@setText()
			@
			
		setText: =>
			text = @model.get('text')
			#console.log text
			@$('.walltext').text(text);
			
		addPost: (model)->
			$(@template).append("<li>" + model.get('text') + "</li>")
	
	window.WallPostView 	= WallPostView	
	
	class AppView extends Backbone.View
		el: '.container'
		countTemplate: _.template($('#wallpostCount').html())
		events:
			"submit #messageForm": "submitPost"
			
		initialize: ->
			#_.bindAll(@, 'render')
			#console.log($('#messageForm'))
			@collection = window.WallPosts 
			@collection.bind('all', @render, @)
			@collection.bind('add', @addOne,@)
			@collection.fetch()
			@render()
		
		render: =>
			#console.log("I did something!")
			variables = 
				total: @collection.length
			$('#count').html(@countTemplate(variables))
			#$('#count').html(@countTemplate$('.wallcount').text(@collection.length))
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
			return false;
			
		addOne: (post) =>
			view = new WallPostView(model: post)
			console.log(view.render().el)
			$("#recents #recents-list").prepend(view.render().el)
	
	window.App			= AppView
	
	# Run a new App.  
	new App()