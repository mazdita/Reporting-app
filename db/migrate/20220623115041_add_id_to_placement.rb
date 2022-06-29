class AddIdToPlacement < ActiveRecord::Migration[6.1]
  def change
    add_column :placements, :placement_id, :integer
  end
end
