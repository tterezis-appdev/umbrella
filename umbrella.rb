require "open-uri"
require "json"

line_width = 40

puts "="*line_width
puts "Will you need an umbrella today?".center(line_width)
puts "="*line_width


p "Where are you located?"

#user_location=gets.chomp

user_location="Feres, Greece"

gmaps_token=ENV.fetch("GMAPS_KEY")

p user_location

gmaps_api_endpoint="https://maps.googleapis.com/maps/api/geocode/json?address=#{user_location}&key=#{gmaps_token}"

raw_response= URI.open(gmaps_api_endpoint).read

parsed_response=JSON.parse(raw_response)

results_array=parsed_response.fetch("results")

first_result=results_array.at(0)

geo=first_result.fetch("geometry")

loc=geo.fetch("location")

latitude=loc.fetch("lat")

longitude=loc.fetch("lng")
  p latitude
  p longitude
  
#Interact with Pirate Weather API
pweather_api_endpoint="https://api.pirateweather.net/forecast/#{ENV.fetch("PIRATE_WEATHER_KEY")}/#{latitude},#{longitude}"

#Assemble correct endpoint
#Read it, parse it, and fetch current temp
raw_pirate_data=URI.open(pweather_api_endpoint).read

parsed_raw_pirate_data=JSON.parse(raw_pirate_data)

p "It is currently #{parsed_raw_pirate_data.fetch("currently").fetch("temperature")}°F."
