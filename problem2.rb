require 'httparty'

def fetch_top_cryptocurrencies
  url = "https://api.coingecko.com/api/v3/coins/markets?vs_currency=usd"
  response = HTTParty.get(url)
  cryptocurrencies = response.parsed_response

  sorted_cryptocurrencies = cryptocurrencies.sort_by { |crypto| -crypto["market_cap"] }

  top_5_cryptocurrencies = sorted_cryptocurrencies.first(5)

  top_5_cryptocurrencies.map do |crypto|
    {
      name: crypto["name"],
      price: crypto["current_price"],
      market_cap: crypto["market_cap"]
    }
  end
end

top_cryptocurrencies = fetch_top_cryptocurrencies

puts "Top 5 Cryptocurrencies by Market Capitalization:"
top_cryptocurrencies.each_with_index do |crypto, index|
  puts "#{index + 1}. #{crypto[:name]} - Price: $#{crypto[:price]}, Market Cap: $#{crypto[:market_cap]}"
end
