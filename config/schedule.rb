# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#

every '0,10,20,30,40,50 * * * *' do
  # command "ruby /usr/src/app/fred-hutch.rb"
end

every '1,11,21,31,41,51 * * * *' do
  # command "ruby /usr/src/app/prepmod.rb"
end

every '2,12,22,32,42,52 * * * *' do
  # command "ruby /usr/src/app/albertsons.rb"
end

every '3,13,23,33,43,53 * * * *' do
  # command "ruby /usr/src/app/albertsons.rb"
end

every '4,14,24,34,44,54 * * * *' do
  command 'ruby /usr/src/app/blake-island.rb --start-date "18-06-2021" --end-date "20-06-2021" --party-size 4'
end

every '5,15,25,35,45,55 * * * *' do
  # command "ruby /usr/src/app/rite-aid-v2.rb 98144"
end

every '6,16,26,36,46,56 * * * *' do
  # command "ruby /usr/src/app/cvs.rb"
end

every '7,17,27,37,47,57 * * * *' do
end

every '8,18,28,38,48,58 * * * *' do
end

every '9,19,29,39,49,59 * * * *' do
end

# Learn more: http://github.com/javan/whenever
