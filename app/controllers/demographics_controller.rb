class DemographicsController < ApplicationController
  def start
  end
  def search
    state = params[:state].split.join("+")
    city = params[:city].split.join("+") #outbounds need pluses
    if Demographic.where(:state => state.split("+").join(" ").titleize, :city => city.split("+").join(" ").titleize).exists?
      @demographic = Demographic.where(:state => state.split("+").join(" ").titleize, :city => city.split("+").join(" ").titleize).first
    else
      key = ENV['ZILLOW']
      data = HTTParty.get("http://www.zillow.com/webservice/GetDemographics.htm?zws-id=#{key}&state=#{state}&city=#{city}").parsed_response

      d = Hash.new

      d["state"] = data['demographics']['response']['region']['state']
      d["city"] = data['demographics']['response']['region']['city']
      d["latitude"] = data['demographics']['response']['region']['latitude'].to_f
      d["longitude"] = data['demographics']['response']['region']['longitude'].to_f
      d["medianHouseholdIncome"] = data['demographics']['response']['pages']['page'][2]['tables']['table'][0]['data']['attribute'][0]['values']['city']['value']['__content__'].to_f
      d["medianSingleFamilyHome"] = data['demographics']['response']['pages']['page'][0]['tables']['table']['data']['attribute'][1]['values']['city']['value']['__content__'].to_f
      d["singleMales"] = data['demographics']['response']['pages']['page'][2]['tables']['table'][0]['data']['attribute'][1]['values']['city']['value']['__content__'].to_f * 100
      d["singleFemales"] = data['demographics']['response']['pages']['page'][2]['tables']['table'][0]['data']['attribute'][2]['values']['city']['value']['__content__'].to_f * 100
      d["medianAge"] = data['demographics']['response']['pages']['page'][2]['tables']['table'][0]['data']['attribute'][3]['values']['city']['value'].to_i
      d["homesWithKids"] = data['demographics']['response']['pages']['page'][2]['tables']['table'][0]['data']['attribute'][4]['values']['city']['value']['__content__'].to_f * 100
      d["owners"] = data['demographics']['response']['pages']['page'][1]['tables']['table'][0]['data']['attribute'][0]['values']['city']['value']['__content__'].to_f * 100
      d["renters"] = data['demographics']['response']['pages']['page'][1]['tables']['table'][0]['data']['attribute'][1]['values']['city']['value']['__content__'].to_f * 100

binding.pry
      Demographic.create( :state => d["state"], :city => d["city"], :latitude => d["latitude"], :longitude => d["longitude"], :household_income => d["medianHouseholdIncome"], :single_family_home => d["medianSingleFamilyHome"], :single_males => d["singleMales"], :single_females => d["singleFemales"], :median_age => d["medianAge"], :homes_with_kids => d["homesWithKids"], :owners => d["owners"], :renters => d["renters"])

      @demographic = Demographic.last
      end

    render 'results'
  end

  def index
    @demographics = Demographic.all
  end

  def new
    @demographic = Demographic.new
  end

  def create
    demographic = Demographic.create(params[:demographic])
    redirect_to(demographic)
  end

  def show
    @demographic = Demographic.find(params[:id])
  end

  def query
    state = params[:state].capitalize.split.join
    city = params[:city].capitalize.split.join
    key = ENV['ZILLOW']

    if Demographic.where(:state => state, :city => city).exists?
      @demographic = Demographic.where(:state => state, :city => city)
      binding.pry
    else
      data = HTTParty.get("http://www.zillow.com/webservice/GetDemographics.htm?zws-id=#{key}&state=#{state}&city=#{city}").parsed_response

      @demographic = Hash.new
      @demographic["state"] = data['demographics']['response']['region']['state']
      @demographic["city"] = data['demographics']['response']['region']['city']
      @demographic["latitude"] = data['demographics']['response']['region']['latitude'].to_f
      @demographic["longitude"] = data['demographics']['response']['region']['longitude'].to_f
      @demographic["medianHouseholdIncome"] = data['demographics']['response']['pages']['page'][2]['tables']['table'][0]['data']['attribute'][0]['values']['city']['value']['__content__'].to_i
      @demographic["medianSingleFamilyHome"] = data['demographics']['response']['pages']['page'][0]['tables']['table']['data']['attribute'][1]['values']['city']['value']['__content__'].to_i
      @demographic["singleFemales"] = data['demographics']['response']['pages']['page'][2]['tables']['table'][0]['data']['attribute'][2]['values']['city']['value']['__content__'].to_f * 100
      @demographic["singleMales"] = data['demographics']['response']['pages']['page'][2]['tables']['table'][0]['data']['attribute'][1]['values']['city']['value']['__content__'].to_f * 100
      @demographic["homesWithKids"] = data['demographics']['response']['pages']['page'][2]['tables']['table'][0]['data']['attribute'][4]['values']['city']['value']['__content__'].to_f * 100
      @demographic["owners"] = data['demographics']['response']['pages']['page'][1]['tables']['table'][0]['data']['attribute'][0]['values']['city']['value']['__content__'].to_f * 100
      @demographic["renters"] = data['demographics']['response']['pages']['page'][1]['tables']['table'][0]['data']['attribute'][1]['values']['city']['value']['__content__'].to_f * 100
      @demographic["medianAge"] = data['demographics']['response']['pages']['page'][2]['tables']['table'][0]['data']['attribute'][3]['values']['city']['value'].to_i
    #binding.pry

      @googleMapURL = "https://maps.google.com/maps?q=#{@demographic["latitude"]}+#{@demographic["longitude"]}+(#{@demographic["city"]})"

      #render 'results'
    end
  end

  def results
  end
end