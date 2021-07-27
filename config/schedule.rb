# Use this file to easily define all of your cron jobs.
#
# It's helpful, but not entirely necessary to understand cron before proceeding.
# http://en.wikipedia.org/wiki/Cron

# Example:
#
# set :output, "/path/to/my/cron_log.log"
#

every 1.hour, at: 0 do
  command 'ruby /usr/src/app/recreation_gov.rb -cohanapecosh'
end

every 1.hour, at: 10 do
  command 'ruby /usr/src/app/recreation_gov.rb -cbig_creek'
end

every 1.hour, at: 20 do
  command 'ruby /usr/src/app/recreation_gov.rb -ctinkham'
end

every 1.hour, at: 30 do
  command 'ruby /usr/src/app/recreation_gov.rb -ccougar_rock'
end

every 1.hour, at: 40 do
  command 'ruby /usr/src/app/recreation_gov.rb -csol_duc'
end

every 1.hour, at: 50 do
  command 'ruby /usr/src/app/recreation_gov.rb -ccolonial_creek'
end


# Learn more: http://github.com/javan/whenever
