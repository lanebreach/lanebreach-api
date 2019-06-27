require 'csv'

# Seed the bikeway networks table:
ActiveRecord::Base.connection.execute(IO.read(Rails.root.join('db', 'sql-files', 'bikeway_networks.sql')))

# Seed the SF 311 cases table with blocked bike lane incidents
# from April 2018 onward:
blocked_lane_cases_csv =
  Sf311CaseService.get_blocked_bike_lane_case_data(
    from_datetime: Date.new(2018, 4, 1),
    limit: 50,
    format: :csv
  )

Sf311Case.ingest_csv_case_data!(blocked_lane_cases_csv)
