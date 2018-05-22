require_relative '../lib/hierarchy'
require_relative 'spec_helper'

describe Hierarchy do
  before :all do
    @lumberg_id = "9431e9b0-1dce-4912-8762-25c43171e9d4"
    @gibbons_id = "d8f06abc-5782-477a-86d1-f54b97085cdb"
    @nagheenanajar_id = "5afad1a9-826c-4db3-9c89-20f412aff428"
    @bolton_id = "12f2e570-ffd7-40c4-8378-0d62a9816120"

    employee_info = [
      {"id" => @lumberg_id, "name" => "Bill Lumbergh", "title" => "Vice President", "manager_id" => nil, "department" => "Engineering"},
      {"id" => @gibbons_id, "name" => "Peter Gibbons", "title" => "Manager", "manager_id" => "9431e9b0-1dce-4912-8762-25c43171e9d4", "department" => "Engineering"},
      {"id" => @nagheenanajar_id, "name" => "Samir Nagheenanajar", "title" => "Software Engineer", "manager_id" => "d8f06abc-5782-477a-86d1-f54b97085cdb", "department" => "Engineering"},
      {"id" => @bolton_id, "name" => "Michael Bolton", "title" => "Software Engineer", "manager_id" => "d8f06abc-5782-477a-86d1-f54b97085cdb", "department" => "Engineering"}]

    @hierarchy = Hierarchy.new(employee_info)
  end

  describe 'manager_ids' do
    it 'returns the correct number of manager ids' do
      expect(@hierarchy.manager_ids.count).to eq(2)
    end

    it 'returns all manager ids in the organization' do
      expect(@hierarchy.manager_ids).to include(@lumberg_id)
      expect(@hierarchy.manager_ids).to include(@gibbons_id)
    end
  end

  describe 'direct_report_ids' do
    it 'returns a set of all direct report employee ids' do
      expect(@hierarchy.direct_report_ids(@lumberg_id)).to include(@gibbons_id)
      expect(@hierarchy.direct_report_ids(@gibbons_id)).to include(@nagheenanajar_id, @bolton_id)
    end 
  end
end