class ReportsController < ApplicationController

  def index
    get_companies
    if @companies != ["NA"]
      @companies_names = @companies.map {|company| company[:name]}
    else
      @companies_names = ["NA"]
    end
    @report = Report.new
    @reports = Report.all.order(date: :desc)

  end


  def create
    @data = get_company_data
    @job_requests_costs = generate_costs_array(@data)
    @total_cost = @job_requests_costs.sum
    report_params = {admin_id: current_admin.id,
                    client: @data.first[:client][:name],
                    title: generate_title(@data),
                    month: Time.zone.now.strftime("%B"),
                    job_requests_names: generate_names_array(@data),
                    job_requests_costs: @job_requests_costs,
                    total_cost: @total_cost}

    @report = Report.new(report_params)
    if @report.save
      redirect_to report_path(@report)
    else
      redirect_to reports_path
    end
  end

  def show
    @report = Report.find(params[:id])
    @comment = Comment.new
    @comments = Comment.where(report_id: params[:id]).order("created_at DESC")
  end

  def destroy
  end

  private 

  def get_companies
    begin
      uri = URI("http://127.0.0.1:3000/api/companies.json")
      params = {token: current_admin.token}
      uri.query = URI.encode_www_form(params)
      res = Net::HTTP.get_response(uri)
      @companies = JSON.parse(res.body, symbolize_names: true)
    rescue
      @companies = ["NA"]
    end
  end

  def get_company_data
    @company = params[:company]

    begin
      uri = URI("http://127.0.0.1:3000/api/data.json")
      params = {token: current_admin.token, client: @company}
      uri.query = URI.encode_www_form(params)
      res = Net::HTTP.get_response(uri)
      @data = JSON.parse(res.body, symbolize_names: true)
    rescue

    end
  end
  
  def generate_title(data)
    name = data.first[:client][:name]
    month = Time.zone.now.strftime("%B")
    year = Time.zone.now.strftime("%Y")
    title = name + " at " + month + ", " + year
  end

  def generate_names_array(data)
    array = []
    data.each {|job| array << job[:job_request][:job_function]}
    return array
  end

  def generate_costs_array(data)
    array = []
    data.each {|job| array << calculate_costs(job)}
    return array
  end

  def calculate_costs(position)
    @days_worked = (Date.current.end_of_month.to_datetime - position[:start_date].to_datetime).to_i
    
    @daily_salary = position[:monthly_salary] / 30

    @cost = @daily_salary * @days_worked
  end


end
