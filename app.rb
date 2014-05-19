require 'sinatra'

get '/' do 
  erb :index
end

get '/register' do
  erb :register
end

get '/login' do
  erb :login
end