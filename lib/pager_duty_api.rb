require 'httparty'

class PagerDutyAPI
  BASE_URL        = 'https://webdemo.pagerduty.com/api/v1'
  TOKEN           = 'VxuRAAxQoTgTjbo7wmmG'
  DEFAULT_HEADERS = { 'Content-Type'  => 'application/json', 'Authorization' => "Token token=#{TOKEN}" }

  def incidents(options = {})
    return_response(HTTParty.get(incidents_path, query: options, headers: DEFAULT_HEADERS))
  end

  private

  def incidents_path
    "#{BASE_URL}/incidents"
  end

  def return_response(response)
    response.code == 200 ? response.parsed_response : {}
  end
end
