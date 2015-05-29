require 'sinatra'
require 'pry'
require "csv"
require "pg"
require "pry"
require "sinatra"

def db_connection
  begin
    connection = PG.connect(dbname: "grocery_list")
    yield(connection)
  ensure
    connection.close
  end
end

nba = CSV.readlines("grocery_list.csv", headers: true)

def groceries_main
inserter =
        "INSERT INTO grocery_list (
          item,
          type,
          amount
        ) VALUES ($1, $2, $3)"
        groceries = CSV.readlines("grocery_list.csv", headers: true)
  groceries.each do |groceries|
    item = groceries["item"]
    type = groceries ["type"]
    amount = groceries["amount"]
    elements = [item,type,amount]

    groceries_main = db_connection do |conn|
      conn.exec_params(inserter, elements)
    end
  end
end


get '/' do
  redirect '/groceries'
end

get '/groceries' do
  @items = CSV.readlines("grocery_list.csv", headers: true)
  erb :index
end

post '/groceries' do
  if params['item'] == ""     # how to catch blank name in form
    redirect '/groceries'
  end
  item = params['item']

  CSV.open('grocery_list.csv', 'a') do |file|
    file.puts(item)
  end

  redirect '/groceries'
end
