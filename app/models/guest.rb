# == Schema Information
#
# Table name: guests
#
#  id         :integer          not null, primary key
#  dob        :date             not null
#  firstname  :string(25)       not null
#  lastname   :string(25)       not null
#  reason     :string(50)       not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Guest < ApplicationRecord
end
