require 'openssl'

namespace :github do
  desc "Generate JWT for github API authorization"
  task generate_jwt: :environment do
    private_pem = File.read(ENV['GITHUB_TOKEN_PEM'])
    private_key = OpenSSL::PKey::RSA.new(private_pem)

    payload = {
      # issued at time
      iat: Time.now.to_i,
      exp: Time.now.to_i + (10 * 60),
      # GitHub App's identifier
      iss: ENV['GITHUB_APP_ID']
    }

    jwt = JWT.encode(payload, private_key, 'RS256')
    puts jwt
  end
end
