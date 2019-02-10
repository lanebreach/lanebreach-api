web: bundle exec puma -C config/puma.rb
worker bundle exec sidekiq

release: rails db:migrate
