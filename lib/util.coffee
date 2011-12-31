class Response
	@json: (res,answer) ->
		res.json(answer,{"Content-type:application/json"})
		
		
class DataUtil
	
		
exports.Response = Response
exports.DataUtil = DataUtil
