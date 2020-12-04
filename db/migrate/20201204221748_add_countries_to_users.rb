class AddCountriesToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :countries, :string
  end
end
