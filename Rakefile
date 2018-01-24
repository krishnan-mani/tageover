require 'aws-sdk-core'
require 'aws-sdk-costexplorer'
require 'aws-sdk-organizations'

require 'date'


AWS_REGION_US_EAST_1 = 'us-east-1'
COST_EXPLORER_API_ENDPOINT_REGION = AWS_REGION_US_EAST_1
ORGANIZATIONS_API_ENDPOINT_REGION = AWS_REGION_US_EAST_1

def list_accounts

  client = Aws::Organizations::Client.new(region: ORGANIZATIONS_API_ENDPOINT_REGION)
  response = client.list_accounts
  response.accounts.collect(&:id)
end

desc "List related account Ids"
task :list_accounts do
  puts list_accounts
end

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

desc "List tags"
task :list_tags do |t, args|

  puts get_tags
end

def get_temporary_credentials(account_id)
  client = Aws::STS::Client.new(region: AWS_REGION_US_EAST_1)
  cross_account_role_arn = "arn:aws:iam::#{account_id}:role/OrganizationAccountAccessRole"
  response = client.assume_role({
                                    role_arn: cross_account_role_arn,
                                    role_session_name: "tageover-#{account_id}"
                                })
  credentials = response.credentials
  {
      access_key_id: credentials.access_key_id,
      secret_access_key: credentials.secret_access_key,
      session_token: credentials.session_token
  }
end

def get_master_account_id

  client = Aws::Organizations::Client.new(region: ORGANIZATIONS_API_ENDPOINT_REGION)
  response = client.describe_organization
  response.organization.master_account_id
end

def other_account?(account_id)
  not (get_master_account_id.eql?(account_id))
end

desc "List tags on a different account"
task :list_tags_for_account, [:account_id] do |t, args|

  account_id = args.account_id or raise 'AWS account Id not specified'

  credentials = other_account?(account_id) ? get_temporary_credentials(account_id) : nil
  puts get_tags(credentials)
end
