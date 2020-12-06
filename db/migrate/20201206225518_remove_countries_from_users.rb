class RemoveCountriesFromUsers < ActiveRecord::Migration[6.0]
  def change
    remove_column :users, :countries
  end
end
