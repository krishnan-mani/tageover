def list_accounts
  require 'aws-sdk-organizations'

  client = Aws::Organizations::Client.new(region: 'us-east-1')
  response = client.list_accounts
  response.accounts.collect(&:id)
end

def get_date_string(now)
  now.strftime('%Y-%m-%d')
end

desc "List related account Ids"
task :list_accounts do
  puts list_accounts
end

desc "List tags for a given region"
task :list_tags, [:region] do |t, args|

  region = args.region or raise "AWS region not specified"

  require 'aws-sdk-costexplorer'
  client = Aws::CostExplorer::Client.new(region: region)

  require 'date'
  now = DateTime.now
  today_str = get_date_string(now)
  last_month_str = get_date_string((now << 1))

  response = client.get_tags(time_period: {
      start: last_month_str,
      end: today_str
  })
  puts response.tags
end