require 'httparty'
require 'json'
require 'pry'
require 'nokogiri'
require 'open-uri'

def query(state, city, neighborhood)
  a = HTTParty.get("http://www.zillow.com/webservice/GetDemographics.htm?zws-id=X1-ZWz1bibqsb2ih7_2xcn2&state=#{state}&city=#{city}&neighborhood=#{neighborhood}")
  #data = XmlSimple.xml_in(a)
  @data = a.parsed_response
end

def get_noko(state, city, neighborhood)
  @doc = Nokogiri::HTML(open("http://www.zillow.com/webservice/GetDemographics.htm?zws-id=X1-ZWz1bibqsb2ih7_2xcn2&state=#{state}&city=#{city}&neighborhood=#{neighborhood}"))

end


puts "state?"
state = gets.chomp
puts "city?"
city = gets.chomp
puts "neighborhood?"
neighborhood = gets.chomp
neighborhood = " " if neighborhood == nil

query(state, city, neighborhood)

binding.pry
#data from zillow

state = @data['demographics']['response']['region']['state']

city = @data['demographics']['response']['region']['city']

neighborhood = @data['demographics']['response']['region']['neighborhood']

latitude = @data['demographics']['response']['region']['latitude']

longitude = @data['demographics']['response']['region']['longitude']

medianHouseholdIncome = @data['demographics']['response']['pages']['page'][2]['tables']['table'][0]['data']['attribute'][0]['values']['city']['value']['__content__']

singleMales = @data['demographics']['response']['pages']['page'][2]['tables']['table'][0]['data']['attribute'][1]['values']['neighborhood']['value']['__content__']

singleFemales = @data['demographics']['response']['pages']['page'][2]['tables']['table'][0]['data']['attribute'][2]['values']['neighborhood']['value']['__content__']

medianAge = @data['demographics']['response']['pages']['page'][2]['tables']['table'][0]['data']['attribute'][3]['values']['neighborhood']['value']['__content__']

homesWithKids = @data['demographics']['response']['pages']['page'][2]['tables']['table'][0]['data']['attribute'][4]['values']['neighborhood']['value']['__content__']

averageHouseholdSize = @data['demographics']['response']['pages']['page'][2]['tables']['table'][0]['data']['attribute'][5]['values']['neighborhood']['value']['__content__']

averageCommuteTime = @data['demographics']['response']['pages']['page'][2]['tables']['table'][0]['data']['attribute'][6]['values']['neighborhood']['value']['__content__']

owners = @data['demographics']['response']['pages']['page'][1]['tables']['table'][0]['data']['attribute'][0]['values']['city']['value']['__content__']

renters = @data['demographics']['response']['pages']['page'][1]['tables']['table'][0]['data']['attribute'][1]['values']['city']['value']['__content__']


#@data['demographics']['response']['pages']

#for google
googleMap = "https://maps.google.com/maps?q=#{latitude}+#{longitude}+(#{neighborhood})"

