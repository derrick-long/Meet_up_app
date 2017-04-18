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
  #okay we fucked something up. Should get a flash message and no rendering of the form unless we're signed in
  if session[:user_id].nil?
    flash[:message] = "Please sign in to add a new meetup!"
    erb :'meetups/new'
  end
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




#maybe make a totally seperate page to do it? Weird fucking problem bro god damn shit ass b
post '/meetups/:id' do
#   #params aint got no fucking meetup id stored when we get here so there's your problem
#   binding.pry
  @meetup_record = MeetupRecord.new(params[:meetuprecord])
  if @meetup_record.save
    flash[:notice] = "Successfully joined meetup!"
    redirect '/meetups'
  end
#   # @users = @meetup.users
#   # @current_user = User.find(session[:user_id])
#   # @current_meetup = @meetup
#   #link is broken
#   #almost there still fucking it up
end

get '/meetups/:id' do

  @meetup = Meetup.find(params[:id])
  @users = @meetup.users
  @current_user = User.find(session[:user_id])
  @current_meetup = @meetup
  #probably need to add some way to add members to a meetup on this page and my index
  erb :'meetups/show'
end
