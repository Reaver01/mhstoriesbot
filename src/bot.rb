require 'bundler/setup'
require 'discordrb'
require 'discordrb/data'
require 'dotenv'
require 'time'
require 'fileutils'
require 'rufus-scheduler'

# This is the Bot
module Bot
  # Copy default database if database doesn't exist
  FileUtils.cp('dbfiles/default.db', 'dbfiles/data.db') unless File.exist?('dbfiles/data.db')
  
  # Load SCHEDULER
  SCHEDULER = Rufus::Scheduler.new
  
  PREFIX = '-'.freeze
  
  # Set prefix
  Dotenv.load

  # Load Modules
  Dir['src/modules/*.rb'].each { |file| load file }

  # Load BOT
  BOT = Discordrb::Commands::CommandBot.new client_id: ENV['CLIENT'],
                                            help_available: true,
                                            help_command: true,
                                            ignore_bots: true,
                                            prefix: PREFIX,
                                            token: ENV['TOKEN']
  # Set permissions
  BOT.set_user_permission(ENV['OWNER'].to_i, 999)

  # Load all command modules
  Dir['src/modules/commands/*.rb'].each { |mod| load mod }
  Commands.constants.each { |mod| BOT.include! Commands.const_get mod }
  
  # Load events
  Dir['src/modules/events/*.rb'].each { |mod| load mod }
  Events.constants.each { |mod| BOT.include! Events.const_get mod }

  BOT.run
end
