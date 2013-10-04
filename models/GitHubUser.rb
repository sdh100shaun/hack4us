require 'github_api'

class GitHubUser
	attr_accessor :github

	def initialize(client_id,client_secret)
		
		@github = Github.new :client_id => client_id, :client_secret => client_secret

	end
	def get_user(user)
		Github.repos.list user: user
	end

	def login

	@github.authorize_url :redirect_uri => '/callback', :scope => 'repo'

	end	
end