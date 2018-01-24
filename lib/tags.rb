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
  return last_month_str, today_str
end

def get_tags(credentials = nil)
  config = {region: COST_EXPLORER_API_ENDPOINT_REGION}
  config.merge!(credentials) unless credentials.nil?

  client = Aws::CostExplorer::Client.new(config)

  last_month_str, today_str = get_start_and_end_dates
  response = client.get_tags(time_period: {
      start: last_month_str,
      end: today_str
  })

  response.tags
end
