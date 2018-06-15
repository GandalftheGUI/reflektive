require 'rubygems'
require 'bundler/setup'
require 'byebug'
require_relative 'lib/reflektive_api_wrapper'
require_relative 'lib/hierarchy'
require_relative 'lib/review_lookup'
require_relative 'lib/org_health'
require_relative 'lib/timer'


#Fetch data from API
Timer.start
employee_info = ReflektiveApiWrapper.get_employee_data
Timer.end("Employee data fetched: ")
Timer.start
review_info = ReflektiveApiWrapper.get_review_data
Timer.end("Review data fetched: ")

#Build hierarchy info 
Timer.start
h = Hierarchy.new(employee_info)
Timer.end("Hierarchy built: ")

#Build review lookup
Timer.start
r = ReviewLookup.new(review_info)
Timer.end("Review lookup built: ")

#Calculate scores 
Timer.start
payload = OrgHealth.process_scores(review_lookup: r, hierarchy: h)
Timer.end("Averages calculated: ")

#Submit response

puts "\nTruncated response:"
puts '*********************************************************'
puts ReflektiveApiWrapper.submit_scores(payload).to_s[0...1000]
puts '*********************************************************'