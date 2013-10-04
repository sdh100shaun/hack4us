require 'mongoid'
require 'json'

class Language
  include Mongoid::document

    field :id, type: Integer
	field :name ,type: String
	
end