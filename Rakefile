desc "List related account Ids"

def list_accounts
  require 'aws-sdk-organizations'

  client = Aws::Organizations::Client.new(region: 'us-east-1')
  response = client.list_accounts
  response.accounts.collect(&:id)
end

task :list_accounts do
  puts list_accounts
end