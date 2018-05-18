require 'rest-client'
require 'oj'

class ReflektiveApiWrapper
  KEY = "Token f400b19a-1704-4c75-9f71-f1afa809aa9d"

  def self.get_employee_data
    get_response("https://reflektive-interview.herokuapp.com/v1/employees")
  end

  def self.get_review_data
    get_response("https://reflektive-interview.herokuapp.com/v1/feedbacks")
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
end