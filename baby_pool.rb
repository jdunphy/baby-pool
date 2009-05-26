require 'rubygems'
require 'sinatra/base'
require 'sequel'
require 'haml'
require File.dirname(__FILE__) + '/lib/db_utils'

class BabyPool < Sinatra::Base
  
  configure do
    env = defined?(environment) ? environment : :development
    dbfile = File.dirname(__FILE__) + "/db/#{env}.sqlite3"
    FileUtils.touch(dbfile)
    ::DB = Sequel.sqlite(dbfile)
    DBUtils.setup_db
    require File.dirname(__FILE__) + '/lib/models'
    puts "GO GO GO"
  end

  get '/' do
    @guesses = Guess.all
    haml :index
  end

  post '/guesses' do
    guess = Guess.new(params['guess'])
    guess.birth_date= "#{params['month']}/#{params['day']}/2009"
    guess.created_at = Time.now
    if guess.valid?
      guess.save
      redirect '/'
    else
      @guesses = Guess.all
      @guess = guess
      haml :index
    end
  end

  helpers do
    def month_options
      out = ""
      {6 => "Jun", 7 => "Jul", 8 => "Aug" }.
        each do |num, month|
        out << "<option value='#{num}'>#{month}</option>\n"
      end
      out
    end

    def day_options
      out = ""
      (1..31).each do |day|
        out << "<option>#{day}</option>\n"
      end
      out
    end

  end
  
end
