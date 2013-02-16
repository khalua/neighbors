class DemographicsController < ApplicationController
  def search
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