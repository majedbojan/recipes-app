# frozen_string_literal: true

Rails.application.config.generators do |g|
  g.orm                 :active_record, primary_key_type: :uuid
  g.test_framework      :rspec
  g.fixture_replacement :factory_bot
  g.factory_bot         dir: 'spec/factories'
  g.assets              nil
  g.helper              false
  g.stylesheets         false
end
