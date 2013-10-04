
require_relative 'models/Hacker'
require_relative 'models/GitHubUser'

require "sinatra/reloader" if development?

class App < Sinatra::Base
  set :static, true
  set :root, File.dirname(__FILE__)
  set :public_folder, 'public'

  configure :development do
    register Sinatra::Reloader
  end

  configure do

    
    set :app ,self.name.to_s.split("::").first
    file_path = File.expand_path("config/"+settings.environment.to_s+".yml", File.dirname(__FILE__))
    config = YAML.load_file(file_path)
    set :env , config[settings.app]

    set :client_id, config['client_id']
    set :client_secret, config['client_secret']

    Mongoid.load!(File.expand_path("config/mongo.yml", File.dirname(__FILE__)), :production)
  end
 
    get '/' do
      
      redirect '/index.html'
      

    end

    get '/hackers.json' do
    	content_type :json

    	users = User.all
    	users.to_json
	end

    get  '/location/:location' do 
      

      

    end

    get '/hacker/:gitHubUser' do 

        githubUser = params[:gitHubUser]

        g = GitHubUser.new(settings.env['client_id'],settings.env['client_secret'])
        user = g.get_user(githubUser)

        erb :index, :locals => { :gitHubUser => user, :loginUrl=>
        g.login}

    end

    get '/callback' do

        puts "callback"
    end

end

