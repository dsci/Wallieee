mongo = require('mongoose')

# Mongo schema
Schema = mongo.Schema
ObjectId = Schema.ObjectId;

WallPostSchema = new Schema
	text: String

WallPost = mongo.model('WallPost', WallPostSchema)

exports.WallPost = WallPost
