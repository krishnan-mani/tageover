require 'aws-sdk-core'
require 'aws-sdk-organizations'

require_relative 'constants'


ORGANIZATIONS_API_ENDPOINT_REGION = AWS_REGION_US_EAST_1

def list_accounts

  client = Aws::Organizations::Client.new(region: ORGANIZATIONS_API_ENDPOINT_REGION)
  response = client.list_accounts
  response.accounts.collect(&:id)
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