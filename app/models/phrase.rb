# == Schema Information
#
# Table name: phrases
#
#  id                  :integer          not null, primary key
#  country             :string
#  original_language   :string
#  original_phrase     :string
#  translated_language :string
#  translated_phrase   :string
#  created_at          :datetime         not null
#  updated_at          :datetime         not null
#
class Phrase < ApplicationRecord
  validates(:original_phrase && :original_language && :translated_language && :translated_phrase,
    {
      :presence => true,
      :uniqueness => { :case_sensitive => false }
    }
  )
end
