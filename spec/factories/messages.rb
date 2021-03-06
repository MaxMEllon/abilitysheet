# == Schema Information
#
# Table name: messages
#
#  id         :integer          not null, primary key
#  body       :string
#  email      :string
#  ip         :inet             not null
#  user_id    :integer
#  state      :boolean          default(FALSE)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

FactoryGirl.define do
  factory :message do
    body 'message'
    ip IPAddr.new('192.168.0.1')
  end
end
