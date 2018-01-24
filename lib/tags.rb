require 'aws-sdk-costexplorer'

require 'date'

require_relative 'constants'


COST_EXPLORER_API_ENDPOINT_REGION = AWS_REGION_US_EAST_1

def get_date_string(now)
  now.strftime('%Y-%m-%d')
end

def get_start_and_end_dates
  now = Date.today
  today_str = get_date_string(now)
  last_month_str = get_date_string((now << 1))
  [last_month_str, today_str]
end

def get_tags(start_date = nil, end_date = nil, credentials = nil)
  config = {region: COST_EXPLORER_API_ENDPOINT_REGION}
  config.merge!(credentials) unless credentials.nil?

  client = Aws::CostExplorer::Client.new(config)

  _start_date, _end_date = (start_date.nil? and end_date.nil?) ?
      get_start_and_end_dates : [get_date_string(start_date), get_date_string(end_date)]
  response = client.get_tags(time_period: {
      start: _start_date,
      end: _end_date
  })

  response.tags
end
