json.array! @case_requests do |case_request|
  json.user_id case_request.user_id
  json.user_handle case_request.user.handle
  json.case_request_count case_request.case_request_count
end