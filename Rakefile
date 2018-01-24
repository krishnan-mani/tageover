require_relative 'lib/organization_accounts'
require_relative 'lib/tags'


desc "List related account Ids"
task :list_accounts do
  puts list_accounts
end


desc "List tags, optionally specify dates as YYYY-mm-dd"
task :list_tags, [:start_date, :end_date] do |t, args|

  start_date = args.start_date
  end_date = args.end_date

  puts get_tags(start_date, end_date)
end


desc "List tags on a different account"
task :list_tags_for_account, [:account_id] do |t, args|
  account_id = args.account_id or raise 'AWS account Id not specified'

  credentials = other_account?(account_id) ? get_temporary_credentials(account_id) : nil
  puts get_tags(nil, nil, credentials)
end
