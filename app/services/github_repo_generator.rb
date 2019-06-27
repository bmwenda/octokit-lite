class GithubRepoGenerator
  include ApiWrapper

  def initialize(username, payload)
    @username = username
    @payload = payload
  end

  def create_repo
    payload_data = HashWithIndifferentAccess.new(filter_github_attributes)
    post("https://api.github.com/users/#{username}/repos", payload_data)
  end

  private

  attr_reader :username, :payload

  def filter_github_attributes
    active_record_keys = %w[id user_id created_at updated_at]
    active_record_keys.each { |key| payload.delete(key) }
    payload
  end
end
