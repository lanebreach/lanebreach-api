# Connect the Sidekiq client and server to Redis:
Sidekiq.configure_server do |config|
  config.redis = { url: ENV['REDIS_URL'] }
end

Sidekiq.configure_client do |config|
  config.redis = { url: ENV['REDIS_URL'] }
end

# Set up the Sidekiq CRON schedule:
SCHEDULE_FILENAME = 'config/schedule.yml'

if File.exist?(SCHEDULE_FILENAME) && Sidekiq.server?
  Sidekiq::Cron::Job.load_from_hash(YAML.load_file(SCHEDULE_FILENAME))
end
