class RemoveAdminFromUsers < ActiveRecord::Migration[6.1]
  def change
    remove_column :users, :admin, :boolean
    remove_column :users, :Admin, :boolean
  end
end
