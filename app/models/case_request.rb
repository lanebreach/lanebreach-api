# == Schema Information
#
# Table name: case_requests
#
#  id         :bigint(8)        not null, primary key
#  meta       :jsonb
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :bigint(8)        not null
#
# Indexes
#
#  index_case_requests_on_user_id  (user_id)
#
# Foreign Keys
#
#  fk_rails_...  (user_id => users.id)
#

class CaseRequest < ApplicationRecord
  belongs_to :user

  def self.get_count(days_back = 0)
    days_back = days_back.to_i
    scope = days_back > 0 ? CaseRequest.where(created_at: days_back.days.ago..Time.current) : CaseRequest      
    scope.group(:user_id).select(:user_id, 'count(*) as case_request_count').order(case_request_count: :desc).includes(:user)
  end
end
