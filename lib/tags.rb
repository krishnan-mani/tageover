require 'aws-sdk-costexplorer'

require 'date'

require_relative 'constants'


COST_EXPLORER_API_ENDPOINT_REGION = AWS_REGION_US_EAST_1

def get_date_string(now)
  now.strftime('%Y-%m-%d')
end

def get_tags(credentials = nil)
  config = {region: COST_EXPLORER_API_ENDPOINT_REGION}
  config.merge!(credentials) unless credentials.nil?

  client = Aws::CostExplorer::Client.new(config)

  now = DateTime.now
  today_str = get_date_string(now)
  last_month_str = get_date_string((now << 1))

  response = client.get_tags(time_period: {
      start: last_month_str,
      end: today_str
  })

  response.tags
end
