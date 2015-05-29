require 'sinatra'
require 'pry'
require "csv"
require "pg"
require "pry"
require "sinatra"

def db_connection
  begin
    connection = PG.connect(dbname: "groceries")
    yield(connection)
  ensure
    connection.close
  end
end

get '/' do
  redirect '/groceries'
end

get '/groceries' do
  grocery_list = db_connection { |conn| conn.exec("SELECT * FROM groceries")}
  erb :index, locals: { grocery_list: grocery_list, error_message: "" }
end

def groceries
  inserter = "INSERT INTO groceries (grocery) VALUES ($1)"
  item = params[:item]

  groceries = db_connection { |conn| conn.exec_params(inserter, [item]) }

end

post '/groceries' do
  item = params[:item]
  if item_error(item) == false
    groceries
    redirect '/groceries'
  else
    grocery_list = db_connection { |conn| conn.exec("SELECT * FROM groceries")}
    erb :index, locals: { grocery_list: grocery_list, error_message: "YOU DIDNT ENTER AN ITEM, TRY AGAIN" }
  end
end

def item_error(item)
  if item == ""
    true
  else
    false
  end
end
