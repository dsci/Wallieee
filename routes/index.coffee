path = require('path')
fs = require('fs')

#Utils = require(process.cwd() + '/utils/util').Response
Response = require('UtilLibrary').Response
DataUtil = require('UtilLibrary').DataUtil

exports.index = (req,res) ->
	res.render('index', {title: 'Express'})
	
exports.api = (req,res) ->
	fs.readFile('./data.yml', "ascii",(err, data) ->
	  throw err if err
	  #console.log(data)
	  answer = require('yaml').eval(data)
	  Response.json(res,answer)	
	)
	