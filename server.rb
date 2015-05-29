require 'sinatra'
require 'pry'
require "csv"
require "pg"
require "pry"
require "sinatra"

def db_connection
  begin
    connection = PG.connect(dbname: "nba")
    yield(connection)
  ensure
    connection.close
  end
end

nba = CSV.readlines("grocery_list.txt", headers: true)










get '/' do
  redirect '/groceries'
end

get '/groceries' do
  @items = File.readlines('grocery_list.txt')
  erb :index
end

post '/groceries' do



  if params['item'] == ""     # how to catch blank name in form
    redirect '/groceries'
  end
  item = params['item']

  File.open('grocery_list.txt', 'a') do |file|
    file.puts(item)
  end

  redirect '/groceries'
end
