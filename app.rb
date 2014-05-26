require 'sinatra'
require 'sqlite3'

get '/' do 
  erb :index
end

get '/register' do
  erb :register
end

post '/register' do
  db = SQLite3::Database.new 'user_login.sqlite'
  
  # TODO: Only allow each username once.
  
  db.execute('INSERT INTO users (email, username, password) VALUES (?, ?, ?)',
     [params[:email], params[:username], params[:password]])
  redirect '/'
end

get '/login' do
  erb :login
end

post '/login' do
  db = SQLite3::Database.new 'user_login.sqlite'
  users = db.execute('SELECT id FROM users WHERE username = ? AND password = ? LIMIT 1',
    [params[:username], params[:password]])  
  if users.size == 0
    @error = 'No user with that username or password found!'
    return erb :login
  end
  redirect '/'
end