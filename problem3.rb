require 'httparty'

def fetch_current_time(area, location)
  url = "http://worldtimeapi.org/api/timezone/#{area}/#{location}"
  response = HTTParty.get(url)
  
  if response.success?
    datetime = response.parsed_response["datetime"]
    {
      area_location: "#{area}/#{location}",
      datetime: datetime
    }
  else
    "Error fetching time for the specified location."
  end
end


area = "Europe"
location = "London"
current_time_info = fetch_current_time(area, location)

if current_time_info.is_a?(Hash)
  puts "The current time in #{current_time_info[:area_location]} is #{current_time_info[:datetime]}"
else
  puts current_time_info  
end