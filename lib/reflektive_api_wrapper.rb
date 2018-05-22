require 'rest-client'
require 'oj'

class ReflektiveApiWrapper
  KEY = 'Token f400b19a-1704-4c75-9f71-f1afa809aa9d'
  EMPLOYEE_URL = 'https://reflektive-interview.herokuapp.com/v1/employees'
  REVIEW_URL = 'https://reflektive-interview.herokuapp.com/v1/feedbacks'
  SUBMISSION_URL = 'https://reflektive-interview.herokuapp.com/v1/manager_submissions'

  def self.get_employee_data
    get_response(EMPLOYEE_URL)
  end

  def self.get_review_data
    get_response(REVIEW_URL)
  end

  def self.submit_scores(payload)
    post(payload)
  end

  private

  def self.get_response(url)
    response = RestClient::Request.execute(
      method: :get,
      url: url,
      headers: {authorization: KEY}
    )

    Oj.load(response.body)
  end

  def self.post(payload)
    # response = RestClient::Request.execute(
    #   method: :post,
    #   payload: payload,
    #   url: SUBMISSION_URL,
    #   headers: {authorization: KEY, accept: :json, content_type: :json}
    # )

    # Oj.load(response.body)


    RestClient::Request.new({
      method: :post,
      url: SUBMISSION_URL,
      payload: Oj.dump(payload),
      headers: {authorization: KEY, content_type: :json}
    }).execute do |response, request, result|
      case response.code
      when 400
        [ :error, Oj.load(response.body) ]
      when 200
        [ :success, Oj.load(response.body) ]
      else
        fail "Invalid response #{response.to_str} received."
      end
    end
  end
end