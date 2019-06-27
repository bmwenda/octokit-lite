module ApiWrapper
  def get(url)
    uri = URI.parse(url)
    http = prepare_http_object(uri)
    response = http.start do |h|
      request = Net::HTTP::Get.new(uri)
      request_with_headers = apply_headers(request)
      h.request(request_with_headers)
    end
    response
  end

  def post(url, payload)
    uri = URI.parse(url)
    http = prepare_http_object(uri)
    response = http.start do |h|
      request = Net::HTTP::Post.new(uri)
      request_with_headers = apply_headers(request)
      request.set_form_data(payload)
      h.request(request_with_headers)
    end
    response
  end

  private

  def apply_headers(request)
    request['Accept'] = 'application/vnd.github.v3+json'
    request
  end

  def prepare_http_object(uri)
    http = Net::HTTP.new(uri.hostname, uri.port)
    http.use_ssl = true if uri.scheme == 'https'
    http
  end
end
