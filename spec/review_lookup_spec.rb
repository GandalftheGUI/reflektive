require_relative '../lib/review_lookup'
require_relative 'spec_helper'

describe ReviewLookup do
  before :all do
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

    @lookup = ReviewLookup.new(review_info)
  end

  describe 'get_scores' do
    it 'returns all scores for the given employee and question' do
      expect(@lookup.get_scores(question_id: @question_id, employee_id: "d8f06abc-5782-477a-86d1-f54b97085cdb")).to eq([[1, 5, 5].reduce(:+) / [1, 5, 5].size.to_f, 3])
    end
  end

  describe 'question_ids' do
    it 'returns the correct number of question ids' do
      expect(@lookup.question_ids.count).to eq(1)
    end

    it 'returns all question ids' do
      expect(@lookup.question_ids).to eq([@question_id])
    end
  end
end
