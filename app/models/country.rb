# == Schema Information
#
# Table name: countries
#
#  id           :integer          not null, primary key
#  capital      :string
#  country_code :string
#  currencies   :string
#  languages    :string
#  last_visited :date
#  name         :string
#  population   :integer
#  region       :string
#  subregion    :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Country < ApplicationRecord
  serialize :languages, Array 
  serialize :currencies, Array 
end
