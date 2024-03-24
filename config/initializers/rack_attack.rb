class Rack::Attack
  # Limits all requests to 5 requests per 10 seconds per IP
  throttle('req/ip', limit: 5, period: 10.seconds) do |req|
    Rails.logger.info "Rack::Attack: #{req.ip} #{req.path} #{req.request_method} blocked."
  end
end
