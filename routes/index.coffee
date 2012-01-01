path = require('path')
fs = require('fs')

#Utils = require(process.cwd() + '/utils/util').Response
#Response = require('UtilLibrary').Response
#DataUtil = require('UtilLibrary').DataUtil
Response = require('./../lib/util').Response
models 	= require('./../lib/mongo')

WallPost = models.WallPost

exports.index = (req,res) ->
	#post = new WallPost()
	#post.text = "Lorem ipsum dolor sit amet, consectetur adipisicing elit, "
	#post.save (err)->
	#	#...
	res.render('index', {title: 'Wallieee'})
	
exports.api = (req,res) ->
	fs.readFile('./data.yml', "ascii",(err, data) ->
	  throw err if err
	  #console.log(data)
	  answer = require('yaml').eval(data)
	  Response.json(res,answer)	
	)
	
exports.posts = (req,res)->
	WallPost.find {}, (err,posts)->
		#console.log(post.text) for post in posts
		Response.json(res,posts)
		
exports.create = (req,res)->
	post = new WallPost()
	post.text = req.body.text
	post.save (err)->
		Response.json(res, {success:true}) unless err