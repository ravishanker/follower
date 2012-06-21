require 'rubygems'
require "bundler/setup"
require 'google_drive'
require 'highline'

# Login in with username and passowrd
local_path = File.dirname(__FILE__)

account_path = File.join(local_path, "account.yaml")

if File.exist?(account_path)
  account = YAML.load_file(account_path)
else
  account = {}
end

if account["use_saved_session"]
  session = GoogleDrive.saved_session
elsif account["mail"] && account["password"]
  session = GoogleDrive.login(account["mail"], account["password"])
else
  highline = HighLine.new()
  mail = highline.ask("Please enter your gmail(user@gmail.com): ")
  password = highline.ask("Please type your Password: "){ |q| q.echo = false }
  session = GoogleDrive.login(mail, password)
end

#session = GoogleDrive.login_with_oauth

# Get spreadsheet
# https://docs.google.com/a/devbootcamp.com/spreadsheet/ccc?key=0AtsLecjMWFCbdEJwNEpRcW5TMU53QV9GX1pPMllfYUE
spreadsheet_key = "0AtsLecjMWFCbdEJwNEpRcW5TMU53QV9GX1pPMllfYUE"
summer_cohorts = session.spreadsheet_by_key(spreadsheet_key).worksheets[0]
#puts summer_cohorts.spreadsheet.worksheets_feed_url
puts summer_cohorts.spreadsheet.human_url
puts summer_cohorts.spreadsheet.title



for row in 1..summer_cohorts.num_rows
  p summer_cohorts.list[row]['Twitter']
end

# Export to a file in formats like xls, csv, ods, tsv or html
#file_path = File.join(local_path, 'boots.csv')
#ss.spreadsheet.export_as_file(file_path, format = 'csv', worksheet_index = 0)

# Return content of the cell as String either by (row number, column number) or cell name

# puts ss["Twitter"]
# puts ss.list[0]['Twitter']

# Dump all cells
#p ss.rows

# Dump cells by column name


# Dump all rows

# for row in 1..ss.num_rows
#   for col in 1..ss.num_cols
#     p ss[row, col]
#   end
# end

# Reload the worksheet to get changes by others

#ss.reload()

