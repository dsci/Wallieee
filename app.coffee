###*
 * Module dependencies.
###

express	= require('express')
fs		= require('fs')
routes	= require('./routes')
yaml 	= require('yaml')#.eval(string_of_yaml)
app 		= module.exports = express.createServer()	 	

# Configuration

app.configure(()->
	app.set('views', __dirname + '/views')
	app.set('view engine', 'jade')
	app.use(express.bodyParser())
	app.use(express.methodOverride());
	app.use(app.router);
	app.use(express.static(__dirname + '/public'));
)

app.configure('development', ()->
	errorHandlerConfig =
		dumpExceptions: true
		showStack: true
	app.use(express.errorHandler(errorHandlerConfig))
)

app.configure('production', ()->
	app.use(express.errorHandler()) 
)

# Routes

app.get('/', routes.index)

app.get('/api', routes.api)

app.get('/news',(req,res)->
	res.render("news.jade",title: "test")
)

app.listen(3000);
console.log("Express server listening on port %d in %s mode", app.address().port, app.settings.env);