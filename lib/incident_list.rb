require_relative 'pager_duty_api'
require_relative 'incident'

class IncidentList
  attr_reader :options, :api_client, :incident_data, :list
  DEFAULT_OPTIONS = { limit: 10, sort_by: 'created_on:desc' }

  def initialize(options = {})
    @options = DEFAULT_OPTIONS.merge(options)
    @api_client = PagerDutyAPI.new
    fetch_incident_data
    parse_incident_data
  end

  def incidents
    list.map { |incident| [incident.created_date_string, incident.assigned_user, incident.status] }
  end

  private

  def fetch_incident_data
    @incident_data = api_client.incidents(options)
  end

  def parse_incident_data
    @list = (incident_data['incidents'] || []).map { |data| Incident.new(data) }
  end
end
