require "./config/environment"
require "./app/models/user"
class ApplicationController < Sinatra::Base

  configure do
    set :views, "app/views"
    enable :sessions
    set :session_secret, "password_security"
  end

  get "/" do
    erb :index
  end

  get "/signup" do
    erb :signup
  end

  post "/signup" do
    #your code here
    if params[:username] == ""
      redirect '/failure'
    end

    @new_user = User.new(username: params[:username], password: params[:password])

    if @new_user.save
      redirect '/login'
    else
      redirect '/failure'
    end

  end

  get '/account' do
    @user = User.find(session[:user_id])
    erb :account
  end


  get "/login" do
    erb :login
  end

  post "/login" do
    ##your code here

    user = User.find_by(username: params[:username])
    if user && user.authenticate(params[:password])
      session[:user_id] = user.id
      redirect '/account'
    else
      redirect '/failure'
    end

  end

  get "/failure" do
    erb :failure
  end

  get "/logout" do
    session.clear
    redirect "/"
  end

  get "/add" do
    if logged_in?
      erb :add
    else
      redirect "/failure"
    end
  end

  post "/add" do
    if logged_in?
      user = current_user
      user.balance += params[:add].to_d
      user.save
      redirect "/account"
    else
      redirect "/failure"
    end
  end

  get "/subtract" do
    if logged_in?
      erb :subtract
    else
      redirect "/failure"
    end
  end

  post "/subtract" do
    if logged_in?
      user = current_user
      if user.balance < params[:subtract].to_d
        erb :withdraw_error
      else
        user.balance = user.balance - params[:subtract].to_d
        user.save
        redirect "/account"
      end
    else
      redirect "/failure"
    end
  end

  helpers do
    def logged_in?
      !!session[:user_id]
    end

    def current_user
      User.find(session[:user_id])
    end
  end

end
