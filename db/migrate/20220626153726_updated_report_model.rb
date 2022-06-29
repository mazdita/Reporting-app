class UpdatedReportModel < ActiveRecord::Migration[6.1]
  def change
    add_column :reports, :client, :string
    add_column :reports, :month, :date
    add_column :reports, :total_cost, :integer
    add_column :reports, :job_requests_names, :string
    add_column :reports, :job_requests_costs, :integer
  end
end
