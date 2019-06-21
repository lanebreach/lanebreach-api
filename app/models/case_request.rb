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
  class InvalidPeriod < StandardError; end
  belongs_to :user

  def self.get_count_by_period(period = '7_DAY')
    scope = case period
    when '1_DAY'
      CaseRequest.where(created_at: 1.day.ago..Time.current)
    when '7_DAY'
      CaseRequest.where(created_at: 7.days.ago..Time.current)
    when '30_DAY'
      CaseRequest.where(created_at: 30.days.ago..Time.current)
    when 'ALL'
      CaseRequest
    else
      raise InvalidPeriod
    end
    scope = scope.group(:user_id).select(:user_id, 'count(*) as case_request_count').order(case_request_count: :desc)
  end
end
