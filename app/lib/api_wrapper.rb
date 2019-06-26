module ApiWrapper
  def get(url)
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.hostname, uri.port)
    http.use_ssl = true if uri.scheme == 'https'
    response = http.start do |h|
      request = Net::HTTP::Get.new(uri)
      request_with_headers = apply_headers(request)
      h.request(request_with_headers)
    end
    response
  end

  private

  def apply_headers(request)
    request['Accept'] = 'application/vnd.github.v3+json'
    request
  end
end
