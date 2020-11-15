class AddLanguagesToCountries < ActiveRecord::Migration[6.0]
  def change
    add_column :countries, :languages, :string
  end
end
