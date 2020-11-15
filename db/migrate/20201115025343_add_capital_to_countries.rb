class AddCapitalToCountries < ActiveRecord::Migration[6.0]
  def change
    add_column :countries, :capital, :string
  end
end
