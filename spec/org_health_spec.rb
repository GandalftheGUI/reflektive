require_relative '../lib/org_health'
require_relative '../lib/hierarchy'
require_relative '../lib/review_lookup'
require_relative 'spec_helper'

describe OrgHealth do
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
    @question_id = "d532e69c-3532-4575-b4a8-74d13050ae6b"
    @question_info = {
      "id" => @question_id,
      "text" => "On a scale of 1-5, how reliable has this person been on submitting his TPS reports"
    }

    review_info = [
      {
        "id" => "48f746c3-0bc5-49f0-b58e-a361dfc438e0",
        "reviewer_id" => "9431e9b0-1dce-4912-8762-25c43171e9d4",
        "recipient_id" => "d8f06abc-5782-477a-86d1-f54b97085cdb",
        "question" => @question_info,
        "score" => 1
      },
      {
        "id" => "5afad1a9-826c-4db3-9c89-20f412aff428",
        "reviewer_id" => "d8f06abc-5782-477a-86d1-f54b97085cdb",
        "recipient_id" => "5afad1a9-826c-4db3-9c89-20f412aff428",
        "question" => @question_info,
        "score" => 4
      },
      {
        "id" => "90126f5b-5fed-43ec-9eb8-554cf0200cbc",
        "reviewer_id" => "d8f06abc-5782-477a-86d1-f54b97085cdb",
        "recipient_id" => "12f2e570-ffd7-40c4-8378-0d62a9816120",
        "question" => @question_info,
        "score" => 4
      },
      {
        "id" => "90126f5b-5fed-43ec-9eb8-554cf0200cbd",
        "reviewer_id" => "5afad1a9-826c-4db3-9c89-20f412aff428",
        "recipient_id" => "12f2e570-ffd7-40c4-8378-0d62a9816120",
        "question" => @question_info,
        "score" => 1
      },
      {
        "id" => "90126f5b-5fed-43ec-9eb8-554cf0200cbe",
        "reviewer_id" => "12f2e570-ffd7-40c4-8378-0d62a9816120",
        "recipient_id" => "5afad1a9-826c-4db3-9c89-20f412aff428",
        "question" => @question_info,
        "score" => 3
      },
      {
        "id" => "410df705-2fbe-479b-9043-3b0bde146fdb",
        "reviewer_id" => "12f2e570-ffd7-40c4-8378-0d62a9816120",
        "recipient_id" => "d8f06abc-5782-477a-86d1-f54b97085cdb",
        "question" => @question_info,
        "score" => 5
      },
      {
        "id" => "96cba485-b4a5-4bbf-84ca-e1e5d291b35c",
        "reviewer_id" => "12f2e570-ffd7-40c4-8378-0d62a9816120",
        "recipient_id" => "d8f06abc-5782-477a-86d1-f54b97085cdb",
        "question" => @question_info,
        "score" => 5
      }
    ]

    @h = Hierarchy.new(employee_info)
    @r = ReviewLookup.new(review_info)    
  end

  describe 'process_scores' do
    it 'averages all employee reviews per manager' do
      payload = OrgHealth.process_scores(review_lookup: @r, hierarchy: @h)
      lumber_score = {:manager_id => @lumberg_id, :question_id => @question_id, :average_score => 3.6666666666666665}
      gibbons_score = {:manager_id => @gibbons_id, :question_id => @question_id, :average_score => 3.0}
      expect(payload).to include(lumber_score, gibbons_score)
    end
  end
end
