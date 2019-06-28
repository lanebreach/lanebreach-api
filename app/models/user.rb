# == Schema Information
#
# Table name: users
#
#  id         :bigint(8)        not null, primary key
#  email      :string
#  first_name :string
#  handle     :string
#  last_name  :string
#  token      :string
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
# Indexes
#
#  index_users_on_email   (email) UNIQUE
#  index_users_on_handle  (handle) UNIQUE
#  index_users_on_token   (token) UNIQUE
#

class User < ApplicationRecord
  validates_uniqueness_of :email, :handle, :token, allow_nil: true, allow_blank: true
end
