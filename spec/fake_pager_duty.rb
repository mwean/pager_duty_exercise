require 'sinatra/base'
require 'json'

class FakePagerDuty < Sinatra::Base
  FAKE_INCIDENT = {"id"=>"P01WMBP", "incident_number"=>7006, "created_on"=>"2013-09-04T23:00:27Z", "status"=>"resolved", "html_url"=>"http://webdemo.pagerduty.com/incidents/P01WMBP", "incident_key"=>"d73e759947354f69b277c51a174eaa54", "service"=>{"id"=>"P6PGZ8U", "name"=>"Alert no-one", "html_url"=>"http://webdemo.pagerduty.com/services/P6PGZ8U", "deleted_at"=>nil}, "escalation_policy"=>{"id"=>"P7CUYED", "name"=>"No-one"}, "assigned_to_user"=>nil, "trigger_summary_data"=>{"description"=>"Something somewhere broke"}, "trigger_details_html_url"=>"http://webdemo.pagerduty.com/incidents/P01WMBP/log_entries/PJA9S1M", "trigger_type"=>"trigger_svc_event", "last_status_change_on"=>"2013-09-05T00:30:27Z", "last_status_change_by"=>nil, "number_of_escalations"=>1, "resolved_by_user"=>nil}

  def self.stub_incidents(incidents)
    @@incidents = incidents
  end

  def self.last_request
    @@last_request
  end

  get '/api/v1/incidents' do
    content_type :json
    @@last_request = { params: params }
    count = (params[:limit] || 100).to_i
    @@incidents ||= count.times.map { FAKE_INCIDENT }

    { incidents: @@incidents }.to_json
  end
end
