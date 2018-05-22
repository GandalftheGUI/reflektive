require 'rubygems'
require 'bundler/setup'
require 'byebug'
require_relative 'lib/reflektive_api_wrapper'
require_relative 'lib/hierarchy'
require_relative 'lib/review_lookup'
require_relative 'lib/org_health'

h = Hierarchy.new(ReflektiveApiWrapper.get_employee_data)
r = ReviewLookup.new(ReflektiveApiWrapper.get_review_data)

payload = OrgHealth.process_scores(review_lookup: r, hierarchy: h)
puts ReflektiveApiWrapper.submit_scores(payload).to_s