require 'rubygems'
require 'bundler/setup'
require_relative 'reflektive_api_wrapper'

puts ReflektiveApiWrapper.get_employee_data.count
puts ReflektiveApiWrapper.get_review_data.count