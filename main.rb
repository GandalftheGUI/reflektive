require 'rubygems'
require 'bundler/setup'
require 'byebug'
require_relative 'reflektive_api_wrapper'
require_relative 'hierarchy'


h = Hierarchy.new(ReflektiveApiWrapper.get_employee_data)
byebug

puts ReflektiveApiWrapper.get_review_data.count