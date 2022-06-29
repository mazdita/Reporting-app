class ChangeJobCostsColumn < ActiveRecord::Migration[6.1]
  def change
    remove_column :reports, :job_requests_costs
    add_column :reports, :job_requests_costs, :string
  end
end
