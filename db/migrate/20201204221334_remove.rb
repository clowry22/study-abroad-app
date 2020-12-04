class Remove < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :county_count
  end
end
