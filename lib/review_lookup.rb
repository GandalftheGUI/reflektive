class ReviewLookup
  def initialize(review_info)
    @lookup = Hash.new{|k,v| k[v] = Hash.new{|k,v| k[v] = []}}
    index_reviews(review_info)
  end

  #employee_id is the employee being reviewed
  def get_scores(question_id:, employee_id:)
    @lookup[question_id][employee_id]
  end

  def question_ids
    @lookup.keys
  end

  private

  def index_reviews(review_info)
    #WARNING: if an employee has reviews from employees who are not their pier 
    # or manager, they will also be included here! Ensure reviews are valid 
    # upstream or add filtering for only valid reviews here.
    review_info.each do |review_hash|
      employee_id = review_hash['recipient_id']
      question_id = review_hash['question']['id']
      score = review_hash['score']

      @lookup[question_id][employee_id] << score
    end
  end
end