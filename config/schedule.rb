# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#

every 1.hour, at: 15 do
  command 'ruby /usr/src/app/wa-state-campground.rb --start-date "20-08-2021" --end-date "22-08-2021" --party-size=2 --campground=penrose_point'
end

every 1.hour, at: 30 do
  command 'ruby /usr/src/app/wa-state-campground.rb --start-date "20-08-2021" --end-date "22-08-2021" --party-size=2 --campground=jarrell_cove'
end


every 1.hour, at: 45 do
  command 'ruby /usr/src/app/wa-state-campground.rb --start-date "20-08-2021" --end-date "22-08-2021" --party-size=2 --campground=illahee'
end


# Learn more: http://github.com/javan/whenever
