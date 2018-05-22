require 'webmock/rspec'
require 'byebug'
require_relative '../lib/reflektive_api_wrapper'

WebMock.disable_net_connect!(allow_localhost: true)

# RSpec.configure do |config|
#   config.before(:each) do
#     stub_request(:get, ReflektiveApiWrapper::EMPLOYEE_URL).
#       to_return(status: 200, body: "employees", headers: {})
#     stub_request(:get, ReflektiveApiWrapper::REVIEW_URL).
#       to_return(status: 200, body: "reviews", headers: {})
#   end
# end