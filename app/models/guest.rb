# == Schema Information
#
# Table name: guests
#
#  id         :integer          not null, primary key
#  city       :string
#  dob        :date
#  firstname  :string(25)       not null
#  id_number  :string
#  lastname   :string(25)       not null
#  reason     :string(50)       not null
#  state      :string
#  zip        :string
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

  validates :firstname, :lastname, :reason, presence: true
end
