# == Schema Information
#
# Table name: users
#
#  id              :integer          not null, primary key
#  password_digest :string
#  username        :string
#  created_at      :datetime         not null
#  updated_at      :datetime         not null
#
class User < ApplicationRecord
  serialize :countries, Array 
  validates(:username,
    {
      :presence => true,
      :uniqueness => { :case_sensitive => false }
    }
  )

  validates(:countries,
    {
      :presence => true,
      :uniqueness => { :case_sensitive => false }
    }
  )

    has_secure_password

end
