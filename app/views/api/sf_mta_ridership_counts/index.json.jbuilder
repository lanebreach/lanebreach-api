json.meta do
  json.current_page @ridership_counts.current_page
  json.next_page @ridership_counts.next_page
  json.prev_page @ridership_counts.previous_page
  json.total_pages @ridership_counts.total_pages
  json.total_count @ridership_counts.total_entries
  json.items_per_page @ridership_counts.per_page
end

json.data @ridership_counts do |ridership_count|
  json.extract! ridership_count, :counter_location, :days,
    :hour_of_collection_time, :month_of_collection_time,
    :year_of_collection_time, :total_bike_count
end
