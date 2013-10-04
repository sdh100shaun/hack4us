


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
    
  end
 
    get '/' do
      
      redirect '/index.html'
      

    end

    get '/users.json' do
    	content_type :json
    	users = User.all
    	users.to_json
	end

    get  '/location/:location' do 
      

      erb :index, :locals => { :location => params[:location] }

    end

    get '/place/:lat/:lon' do 

        place = Place.new
        
        lat = params[:lat]
        lng = params[:lon]

        place.get_place_info(lat,lng)

    end

    get '/weather/:lat/:lon' do 

        lat = params[:lat]
        lng = params[:lon]
        weather = Weather.new(lat,lng)
        weather.get_weather
        code_info = Weather.where(code:weather.code)[0]

        {"temp"=>weather.temp,"text"=>weather.text,"svg"=>code_info['svg'].to_s}.to_json
    end

end

