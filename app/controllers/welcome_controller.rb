class WelcomeController < ApplicationController
  def test
  	wunder_response = HTTParty.get("http://api.wunderground.com/api/#{ENV['wunderground_api_key']}/conditions/q/CA/San_Francisco.json")
  
  	@location = wunder_response['current_observation']['display_location']['city']
  	@temp_f = wunder_response['current_observation']['temp_f']
  	@temp_c = wunder_response['current_observation']['temp_c']
  	@weather_icon = wunder_response['current_observation']['icon_url']
  	@forecast_link = wunder_response['current_observation']['forecast_url']
  	@feels_like = wunder_response['current_observation']['feelslike_f']
  end

  def index

     @states = %w(HI AK CA OR WA ID UT NV AZ NM CO WY MT ND SD NB KS OK 
     TX LA AR MO IA MN WI IL IN MI OH KY TN MS AL GA FL SC NC VA WV DE MD PA NY 
     NJ CT RI MA VT NH ME DC).sort!

     if params[:city] != nil
        params[:city].gsub(" ", "_")
     end

     if params[:state] != ' ' && params[:city] != ' ' && params[:state] != nil && params[:city] != nil
         wunder_response = HTTParty.get("http://api.wunderground.com/api/#{Figaro.env.wunderground_api_key}/geolookup/conditions/q/#{params[:state]}/#{params[:city]}.json")

         if wunder_response['response']['error'] == nil || wunder_response['response']['error'] == ''
          @location = wunder_response['current_observation']['display_location']['city']
          @temp_f = wunder_response['current_observation']['temp_f']
          @temp_c = wunder_response['current_observation']['temp_c']
          @weather_icon = wunder_response['current_observation']['icon_url']
          @forecast_link = wunder_response['current_observation']['forecast_url']
          @feels_like = wunder_response['current_observation']['feelslike_f']
        else
          @error = wunder_response['response']['error']['description']
        end
    end
  end
end
