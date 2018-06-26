module Bot
  # Schedules Cron jobs https://crontab.guru/ for reference
  module Cron
    # Does something every 10 mins
    SCHEDULER.every '30s' do
      # nothing for now
    end

    # Does something every 10 mins
    SCHEDULER.every '10m' do
      # nothing for now
    end

    # Does something every 30 mins
    SCHEDULER.every '30m' do
      # nothing for now
    end

    # Does something every 3 hours
    SCHEDULER.every '3h' do
      # nothing for now
    end

    # Does something every 24 hours
    SCHEDULER.every '24h' do
      # nothing for now
    end

    SCHEDULER.cron '0 0 * * 0' do
      # Backup database
      begin
        FileUtils.cp('botdb/data.db', "botdb/data#{Time.now.strftime('%Y%m%d')}.db")
      rescue
        puts 'Database backup failed!'
      end
    end
  end
end
