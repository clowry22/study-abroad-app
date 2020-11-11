# == Schema Information
#
# Table name: countries
#
#  id           :integer          not null, primary key
#  last_visited :date
#  name         :string
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Country < ApplicationRecord
end
