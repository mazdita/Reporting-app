class AddTokenToAdmins < ActiveRecord::Migration[6.1]
  def change
    add_column :admins, :token, :string
  end
end
