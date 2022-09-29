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
#  user_id    :integer          not null
#
# Indexes
#
#  index_guests_on_user_id  (user_id)
#
# Foreign Keys
#
#  user_id  (user_id => users.id)
#
class Guest < ApplicationRecord
  belongs_to :user
end
