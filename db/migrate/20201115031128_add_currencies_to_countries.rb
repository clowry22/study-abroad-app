class AddCurrenciesToCountries < ActiveRecord::Migration[6.0]
  def change
    add_column :countries, :currencies, :string
  end
end
