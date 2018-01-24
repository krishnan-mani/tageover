require 'date'

require_relative 'lib/organization_accounts'
require_relative 'lib/tags'


desc <<HERE
List all account Ids that are part of the organization
HERE
task :list_accounts do
  puts list_accounts
end


def get_start_and_end_dates(args)
  start_date = args.start_date.nil? ? nil : Date.strptime(args.start_date)
  end_date = args.end_date.nil? ? nil : Date.strptime(args.end_date)
  raise 'Specify both start and end dates' if (end_date.nil? and (not (start_date.nil?)))
  [start_date, end_date].sort
end


desc <<HERE
List tags, optionally specify start and end dates in the format "YYYY-mm-dd"
Order of dates does not matter
For example:
rake list_tags[2017-12-25','2018-01-25']

When not specified, end date and start date are defaulted to today, and a month ago respectively
HERE
task :list_tags, [:start_date, :end_date] do |t, args|
  start_date, end_date = get_start_and_end_dates(args)

  puts get_tags(start_date, end_date)
end


desc <<HERE
List tags on an account in the organization (by account Id)
Optionally, specify start and end dates in the format "YYYY-mm-dd". Order of dates does not matter
For example:
rake list_tags_for_account['123456789012','2017-12-25','2018-01-25']

When not specified, end date and start date are defaulted to today, and a month ago respectively
HERE
task :list_tags_for_account, [:account_id, :start_date, :end_date] do |t, args|
  account_id = args.account_id or raise 'AWS account Id not specified'
  start_date, end_date = get_start_and_end_dates(args)

  credentials = other_account?(account_id) ? get_temporary_credentials(account_id) : nil
  puts get_tags(start_date, end_date, credentials)
end
