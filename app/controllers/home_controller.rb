require "uri"
require "net/http"
require 'json'
require "csv"

class HomeController < ApplicationController
  before_action :authenticate_admin!, only: [:dashboard]
  def index
    
    url = request.original_url
    if url.include? "?"
      @csv_url = url.insert(url.index("?"), ".csv")
    else
      @csv_url = url + ".csv"
    end
    @placements = api_request
    
    respond_to do |format|
        format.html
        format.csv {send_data @placements.to_csv}
    end
    # if @placements.blank?
    #   render html: "nothing to show"
    # end
  end

  def download
    
  end

  def dashboard
    @placements = api_request
  end

  def api_request
    data = make_request
  end

  def make_request
    begin
      @client = params[:client]
      @worker = params[:worker]
      @function = params[:job_function]
      @start_date = params[:start_date]
      @end_date = params[:end_date]
      

      uri = URI("http://127.0.0.1:3000/api/data.json")
      params = {token: current_admin.token,
                client: @client,
                worker: @worker,
                function: @function,
                start_date: @start_date,
                end_date: @end_date}
      uri.query = URI.encode_www_form(params)
      # puts uri
      
      res = Net::HTTP.get_response(uri)
      @data = JSON.parse(res.body, symbolize_names: true) 
    rescue
      render html: "<h1><strong>NO CONNECTION</strong></h1>".html_safe
    end
    
  end

  def save_placements
    @placements.each do |placement| 
    placement_id = placement[:id]
    existent_placement = Placement.find(placement_id)
    if existent_placement
      existent_placement.update(
        client_name: placement[:client][:name],
        worker_first_name: placement[:worker][:first_name],
        job_function: placement[:job_request][:job_function] ,
        start_date: placement[:start_date] ,
        end_date: placement[:end_date] ,
        monthly_salary: placement[:monthly_salary]
      )
      existent_placement.save
    else
      Placement.create(
        placement_id: placement[:id],
        client_name: placement[:client][:name],
        worker_first_name: placement[:worker][:first_name],
        job_function: placement[:job_request][:job_function] ,
        start_date: placement[:start_date] ,
        end_date: placement[:end_date] ,
        monthly_salary: placement[:monthly_salary] 
        )
    end
  end
  



end
end

class Array
  def to_csv
    attributes = %w(client worker_name  job_function start_date end_date monthly_salary)

    CSV.generate do |csv|
      csv << attributes

      self.each do |placement|
        csv << [placement[:client][:name], placement[:worker][:first_name], placement[:job_request][:job_function], placement[:start_date], placement[:end_date], placement[:monthly_salary]]
      end
    end
  end
end