class AuthenticateUser
  def initialize(username, password)
    @username = username
    @password = password
  end

  def generate_token
    JwtHandler.encode(user_id: user.id) if user
  end

  private

  attr_reader :username, :password

  def user
    user ||= User.find_by(username: username)
    return user if user && user.authenticate(password)
    { error: 'Invalid credentials' }
  end
end
