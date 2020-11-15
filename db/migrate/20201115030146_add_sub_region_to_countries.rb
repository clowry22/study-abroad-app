class AddSubRegionToCountries < ActiveRecord::Migration[6.0]
  def change
    add_column :countries, :subregion, :string
  end
end
