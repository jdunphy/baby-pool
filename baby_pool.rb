require 'rubygems'
require 'sinatra/base'
require 'sequel'
require 'haml'
require File.dirname(__FILE__) + '/lib/db_utils'

class BabyPool < Sinatra::Base
  
  configure do
    env = defined?(environment) ? environment : :development
    if ENV['DATABASE_URL'] 
      ::DB = Sequel.connect(ENV['DATABASE_URL'])
    else
      dbfile = File.dirname(__FILE__) + "/db/#{env}.sqlite3"
      FileUtils.touch(dbfile)
      ::DB = Sequel.sqlite(dbfile)
    end
    DBUtils.setup_db

    require File.dirname(__FILE__) + '/lib/models'
  end

  get '/' do
    @guesses = Guess.order(:created_at.desc).all
    haml :index
  end
  
end
