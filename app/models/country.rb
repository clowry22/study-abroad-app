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
#  userid       :integer
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Country < ApplicationRecord
  serialize :languages, Array 
  serialize :currencies, Array 

    validates(:name,
    {
      :presence => true,
      :uniqueness => { :case_sensitive => false }
    }
  )
end
