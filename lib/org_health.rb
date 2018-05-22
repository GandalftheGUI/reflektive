class OrgHealth
  #O(n * m) where n = number of employees and m = number of reviews
  # direct-reports + managers <= 2(n)
  # questions <= m
  # questions + m <= 2(m)
  # worst case 2m * 2n ~= O(n * m)
  def self.process_scores(review_lookup:, hierarchy:)
    questions = review_lookup.question_ids
    payload = []

    hierarchy.manager_ids.each do |manager_id|
      questions.each do |question_id|
        entry = {}
        entry[:manager_id] = manager_id
        entry[:question_id] = question_id

        score_total = 0
        score_count = 0

        hierarchy.direct_report_ids(manager_id).each do |employee_id|
          avg, num_scores = review_lookup.get_scores(question_id: question_id, employee_id: employee_id)
          score_total += (avg * num_scores)
          score_count += num_scores
        end

        entry[:average_score] = score_total.to_f / score_count

        payload << entry
      end
    end

    return payload
  end
end