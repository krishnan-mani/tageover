Read all tags across related AWS accounts

Usage
===

- Has ```rake``` tasks you can run to get tags on an AWS account, and related accounts within an AWS Organization.

```
$ rake -T
rake list_accounts                                          # List all acco...
rake list_tags[start_date,end_date]                         # List tags, op...
rake list_tags_for_account[account_id,start_date,end_date]  # List tags on ...

$ rake -D list_accounts
rake list_accounts
    List all account Ids that are part of the organization

$ rake -D list_tags
rake list_tags[start_date,end_date]
    List tags, optionally specify start and end dates in the format "YYYY-mm-dd"
    Order of dates does not matter
    For example:
    rake list_tags[2017-12-25','2018-01-25']

    When not specified, end date and start date are defaulted to today, and a month ago respectively

rake list_tags_for_account[account_id,start_date,end_date]
    List tags on an account in the organization (by account Id)
    Optionally, specify start and end dates in the format "YYYY-mm-dd". Order of dates does not matter
    For example:
    rake list_tags_for_account['123456789012','2017-12-25','2018-01-25']

    When not specified, end date and start date are defaulted to today, and a month ago respectively

```

- From the master account in the organization, you can run ```rake``` tasks using IAM credentials to ```sts:AssumeRole``` on the ```OrganizationAccountAccessRole``` (present "a priori" on all accounts that are part of the organization)

Tasks
===

- List tags: You can list tags directly on any account (regardless of whether the account is part of an organization)
- List accounts: Lists the AWS account Ids for all accounts that are part of the organization (from the master account) 
- List tags for account: List tags for the account that is a part of the organization (from the master account)

HOW-TO
===

- Recommended: Install [rvm](https://rvm.io/) and use a gemset with ruby ```ruby-2.4.1```

```
$ rvm current
ruby-2.4.1@tageover
$ gem install bundler --no-ri --no-rdoc
$ bundle install --binstubs

```

- Generate credentials for an IAM user on the master account (or use one of the [supported mechanisms to configure credentials](https://docs.aws.amazon.com/sdk-for-ruby/v3/developer-guide/setup-config.html))
 
```
# setting an environment variable for a profile configured with AWS CLI (for the fish shell)

$ set -x AWS_PROFILE km@enceladus
$ echo $AWS_PROFILE
km@enceladus
     
```

TODO
===

- [ ] Add task to get tags on all accounts within an organization
- [x] Allow user input for start and end dates for ```list_tags``` (currently assumes an ```End``` date of today and ```Start``` date a month ago) 
- [ ] Implement pagination for API calls
- [ ] Add a command-line invocation as an alternative to ```rake``` tasks
- [ ] More testing

References
===

See below for AWS API actions invoked:

- [Cost Explorer API: get-tags](https://docs.aws.amazon.com/aws-cost-management/latest/APIReference/API_GetTags.html)
- [Organizations API: describe-organization](https://docs.aws.amazon.com/organizations/latest/APIReference/API_DescribeOrganization.html)
- [Organizations API: list-accounts](https://docs.aws.amazon.com/organizations/latest/APIReference/API_ListAccounts.html) 
- [STS API: assume-role](https://docs.aws.amazon.com/STS/latest/APIReference/API_AssumeRole.html)
