require 'bundler'
Bundler.setup(:default)
require 'optparse'
require_relative 'lib/incident_list'

options = {}
OptionParser.new do |opts|
  opts.banner = "Usage: pd_incidents.rb [options]"

  opts.on('-l', '--limit [NUMBER]', Integer, 'Number of incidents to return') do |limit|
    options[:limit] = limit
  end
end.parse!

puts IncidentList.new(options).incidents.map { |data| data.join(', ') }.join("\n")
