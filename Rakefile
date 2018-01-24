require 'date'

require_relative 'lib/organization_accounts'
require_relative 'lib/tags'


desc "List related account Ids"
task :list_accounts do
  puts list_accounts
end


def get_start_and_end_dates(args)
  start_date = args.start_date.nil? ? nil : Date.strptime(args.start_date)
  end_date = args.end_date.nil? ? nil : Date.strptime(args.end_date)
  raise 'Specify both start and end dates' if (end_date.nil? and (not (start_date.nil?)))
  [start_date, end_date].sort
end


desc "List tags, optionally specify dates as YYYY-mm-dd"
task :list_tags, [:start_date, :end_date] do |t, args|
  start_date, end_date = get_start_and_end_dates(args)

  puts get_tags(start_date, end_date)
end


desc "List tags on a different account"
task :list_tags_for_account, [:account_id, :start_date, :end_date] do |t, args|
  account_id = args.account_id or raise 'AWS account Id not specified'
  start_date, end_date = get_start_and_end_dates(args)

  credentials = other_account?(account_id) ? get_temporary_credentials(account_id) : nil
  puts get_tags(start_date, end_date, credentials)
end
