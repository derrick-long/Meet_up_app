require 'sinatra'
require "sinatra/activerecord"
require 'sinatra/flash'
require_relative 'config/application'
enable :sessions




set :bind, '0.0.0.0'  # bind to all interfaces

helpers do
  def current_user
    if @current_user.nil? && session[:user_id]
      @current_user = User.find_by(id: session[:user_id])
      session[:user_id] = nil unless @current_user
    end
    @current_user
  end
end

get '/' do
  redirect '/meetups'
end


get '/auth/github/callback' do
  user = User.find_or_create_from_omniauth(env['omniauth.auth'])
  session[:user_id] = user.id
  flash[:notice] = "You're now signed in as #{user.username}!"

  redirect '/'
end

get '/sign_out' do
  session[:user_id] = nil
  flash[:notice] = "You have been signed out."

  redirect '/'
end

get '/meetups' do
  @ordered_meetups = Meetup.all.order('meetup_name ASC')
  erb :'meetups/index'
end

get '/meetups/new' do
  flash[:notice] = "Please sign in to add a new meetup!"
  @meetup = Meetup.new
  erb :'meetups/new'
end

post '/meetups' do
  @meetup = Meetup.new(params[:meetup])
  if @meetup.save
  flash[:notice] = "New meetup added!"
  redirect '/meetups'
  else
    flash[:error] = @meetup.errors.full_messages
    #need to submit form with ajax request
    redirect '/meetups/new'
  end
  erb :'meetups/new'
end




post '/meetups/:id' do
  @meetup_record = MeetupRecord.new(params[:meetuprecord])
  if @meetup_record.save
    flash[:notice] = "Successfully joined meetup!"
    redirect '/meetups'
  end

end

get '/meetups/:id' do
  @meetup = Meetup.find(params[:id])
  @users = @meetup.users
  if session[:user_id].nil?
    #look up why I have to refresh here
    flash[:notice] = "Please sign in to join a meetup!"
  else
    @current_user = User.find(session[:user_id])
    @current_meetup = @meetup
  end
  erb :'meetups/show'
end
