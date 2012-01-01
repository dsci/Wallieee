###*
 * Module dependencies.
###

express	= require('express')
fs		= require('fs')
routes	= require('./routes')
yaml 	= require('yaml')#.eval(string_of_yaml)
app 		= module.exports = express.createServer()	 	
mongo 	= require('mongoose')

# Configuration

app.configure(()->
	app.set('views', __dirname + '/views')
	app.set('view engine', 'jade')
	app.use(express.bodyParser())
	app.use(express.methodOverride())
	app.use(app.router)
	app.use(express.static(__dirname + '/public'))
)

app.configure('development', ()->
	errorHandlerConfig =
		dumpExceptions: true
		showStack: true
	app.use(express.errorHandler(errorHandlerConfig))
	# configure mongo connection
	mongo.connect("mongodb://localhost/wallieee")
)

app.configure('production', ()->
	app.use(express.errorHandler())
	port = ""
	user = "wallie"
	pwd = "123456"
	host = "staff.mongohq.com"
	collection = "app2285044"
	mongo.connect("mongodb://"+user+":"+pwd+"@"+host+":10067/" + collection)
)
# Routes

app.get('/', routes.index)

app.get('/posts', routes.posts)

app.post('/posts', routes.create)

port = process.env.PORT or 3000;
app.listen(port)

console.log("Express server listening on port %d in %s mode", app.address().port, app.settings.env)