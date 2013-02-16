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
    state = params[:state].split.join
    city = params[:city].split.join
    key = ENV['ZILLOW']
    data = HTTParty.get("http://www.zillow.com/webservice/GetDemographics.htm?zws-id=#{key}&state=#{state}&city=#{city}").parsed_response

    begin
      @state = data['demographics']['response']['region']['state']
      @city = data['demographics']['response']['region']['city']
      @latitude = data['demographics']['response']['region']['latitude']
      @longitude = data['demographics']['response']['region']['longitude']

      @medianHouseholdIncome = data['demographics']['response']['pages']['page'][2]['tables']['table'][0]['data']['attribute'][0]['values']['city']['value']['__content__']
      @medianSingleFamilyHome = data['demographics']['response']['pages']['page'][0]['tables']['table']['data']['attribute'][1]['values']['city']['value']['__content__']


      singleFemales = data['demographics']['response']['pages']['page'][2]['tables']['table'][0]['data']['attribute'][2]['values']['city']['value']['__content__']
      @singleFemales = singleFemales.to_f * 100

      singleMales = data['demographics']['response']['pages']['page'][2]['tables']['table'][0]['data']['attribute'][1]['values']['city']['value']['__content__']
      @singleMales = singleMales.to_f * 100


      homesWithKids = data['demographics']['response']['pages']['page'][2]['tables']['table'][0]['data']['attribute'][4]['values']['city']['value']['__content__']
      @homesWithKids = homesWithKids.to_f * 100

      owners = data['demographics']['response']['pages']['page'][1]['tables']['table'][0]['data']['attribute'][0]['values']['city']['value']['__content__']
      @owners = owners.to_f * 100

      renters = data['demographics']['response']['pages']['page'][1]['tables']['table'][0]['data']['attribute'][1]['values']['city']['value']['__content__']
      @renters = renters.to_f * 100

      @medianAge = data['demographics']['response']['pages']['page'][2]['tables']['table'][0]['data']['attribute'][3]['values']['city']['value']

    rescue
    end

    @googleMapURL = "https://maps.google.com/maps?q=#{@latitude}+#{@longitude}+(#{@city})"

    render 'results'

  end

  def results
  end
end