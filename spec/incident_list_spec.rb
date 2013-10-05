require 'bundler'
Bundler.setup(:default, :test)
require_relative '../lib/incident_list'
require 'rspec'
require 'webmock/rspec'
require_relative 'fake_pager_duty'

describe IncidentList do
  before(:each) { stub_request(:any, /.*pagerduty.*/).to_rack(FakePagerDuty) }
  it 'fetches (10 by default) incidents from the PagerDuty API' do
    expect(IncidentList.new.incidents.size).to eql(10)
  end

  it 'returns the correct data for each incident' do
    incident = {
      'created_on'       => '2013-09-04T23:00:27Z',
      'status'           => 'resolved',
      'assigned_to_user' => nil
    }
    FakePagerDuty.stub_incidents([incident])

    expect(IncidentList.new.incidents[0]).to eql(['9/4/2013', 'No one assigned', 'resolved'])
  end

  it 'fetches incidents in descending date order by default' do
    IncidentList.new

    expect(FakePagerDuty.last_request[:params][:sort_by]).to eql('created_on:desc')
  end
end
