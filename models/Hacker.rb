require 'mongoid'
require 'json'

class Hacker
  include Mongoid::Document

    field :id, type: Integer
	field :name ,type: String
	field :twitter, type:String
	field :course,type:String
	field :uniUsername, type:String
	field :github, type:String
end