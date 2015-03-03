# This file is copied to spec/ when you run 'rails generate rspec:install'
ENV['RAILS_ENV'] ||= 'test'
require 'spec_helper'
require File.expand_path('../../config/environment', __FILE__)
require 'rspec/rails'

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = true
  config.infer_spec_type_from_file_location!

  def sign_up
      visit signup_path
        within(".form-horizontal") do
          click_on("Sign Up")
        end
      fill_in "First Name", with: "Con"
      fill_in "Last Name", with: "Queso"
      fill_in "Email", with: "cheese@melted.com"
      fill_in "Password", with: "password"
      fill_in "Password Confirmation", with: "password"
        within(".form-horizontal") do
          click_on("Sign Up")
        end
    end
  end
