require 'mongoid'
require 'json'

class Language
  include Mongoid::Document

    field :id, type: Integer
	field :name ,type: String
	
end