class JwtHandler
  HMAC_SECRET = Rails.application.secrets.secret_key_base

  def self.encode(payload)
    payload[:exp] = 24.hours.from_now.to_i
    JWT.encode(payload, HMAC_SECRET, 'HS256')
  end

  def self.decode(token)
    decoded_token = JWT.decode(token, HMAC_SECRET, true, algorithm: 'HS256')[0]
    HashWithIndifferentAccess.new(decoded_token)
  rescue JWT::ExpiredSignature, JWT::VerificationError => e
    e.to_json
  end
end
