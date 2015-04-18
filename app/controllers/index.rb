# before '/favorites' do
#   save_intended_url
#   # session[:intended_page] = "/s/#{params[:splat]}"
#   redirect "/login" unless logged_in?
# end

# after '/login' do
#   visit_intended_url
# end

before '/favorites' do
  redirect "/login" unless logged_in?
end

get '/' do
  # session[:id]
  erb :index
end

get '/browse' do
  @all_dogs = Dog.all.sort

  erb :browse
end

get '/search' do
  # @breed_list = Dog.where(breed: params[:breed])
  erb :search_results
end

post '/search' do

  # search_breed = params[:breed]
  @breed_list = Dog.where(breed: params[:breed].capitalize)

  content_type :json
  @breed_list.to_json
end

get '/search/results' do
  @breed_list = Dog.where(breed: params[:breed].capitalize)

  erb :search_results_index
end

get '/login' do
  erb :login
end

post '/login' do
  @user = User.find_by(username: params[:username])
  #if the username matches the db, then, redirect them to the main page
  if @user && @user.password == params[:password]
    session[:user_id] = @user.id #it stores the volunteer_id, which indicates they are logged in so they don't have to keep logging in and you don't have to keep looking their volunteer info when they go to a different page
    redirect '/'
  else
    @error = true
    erb :login
  end

end

# before '/admin/*' do
#   # make sure theey're admin or reduirect
# end

get '/options' do
  @all_dogs = Dog.all.sort
  erb :options
end

post '/options' do
  @rate_this_dog = Dog.find(params[:id])

  redirect "/options/#{params[:id]}/change"
end

get '/options/:id/change' do
  @view_dog = Dog.find(params[:id])

  erb :changeprofile
end

get '/dogs/:id/edit' do
  @edit_dog = Dog.find(params[:id])

  erb :dogs_edit
end

put '/dogs/:id/edit' do
  @edit_dog = Dog.find(params[:dog_id])

  changes = params.select {|key, value| value != ""}
  changes.delete("_method")
  changes.delete("dog_id")
  changes.delete("splat")
  changes.delete("captures")
  changes.delete("id")
  @edit_dog.update_attributes(changes)
  redirect "/dogs/#{params[:dog_id]}"
end

get '/dogs/new' do
  erb :dogs_new_profile
end

post '/dogs/new' do
  @new_dog = Dog.create!(params)
  redirect "/dogs/#{@new_dog.id}"
end

delete '/dogs/:id/delete' do
  @delete_dog = Dog.find(params[:id])
  @delete_dog.destroy
  redirect '/options'
end

get '/register' do
  erb :register
end

post '/register' do
  new_user = User.new(params)
  if new_user.save
    session[:user_id] = new_user.id
    redirect '/'
  else
    @invalid_error = new_user.errors.full_messages.join(" ")
    erb :register
  end
end

get '/browse' do
  erb :browse
end

get '/dogs/:id' do
  @view_dog = Dog.find(params[:id])
  @all_ratings = @view_dog.ratings

  @valid_comments = @all_ratings.select {|rating| rating.comments != nil && rating.comments != " " && rating.comments != ""}

  @valid_videos = @all_ratings.select {|rating| rating.video_url != nil && rating.video_url != ""}
  @colors = ["#E8A0B8", "#FFC300", "#BCCF3D", "#32DEDE", "#A8AAE0", "rgb(237, 87, 87)", "#1AC6AE" ]
  # binding.pry
  # if it's an ajax request, apply _profile
  if request.xhr?
    erb :_profiles, layout: false
  else
    erb :profile
  end
end

get '/dogs/:id/rate' do
  if logged_in?
    @view_dog = Dog.find(params[:id])
    erb :rate
  else
    redirect '/login'
  end
end

post '/dogs/:id' do
  view_dog = Dog.find(params[:id])
  rating = view_dog.ratings.create(params[:dog])
  redirect "/dogs/#{view_dog.id}"
end


get '/randomize' do
  redirect "dogs/#{Dog.all.sample.id}"
end

get '/favorites' do

  if session[:user_id]
    user_id = session[:user_id]
    @user_faves = User.find(user_id).favorites
  else
    @login_error = "please log in to see your      <% end %> favorites."
  end

  erb :favorites
end


post '/favorites' do

  if session[:user_id]
    user_id = session[:user_id]
    params[:favorite_ids].each do |id|
      Favorite.create(user_id: user_id, dog_id: id.to_i)
    end
  else
    redirect '/favorites'
  end

end

get '/crazydogs' do

  erb :crazydogperson
end

get '/gifs' do
  content_type :json
  Gif.all.to_json
end

post '/crazydogs' do
  dog_json = params['gifArray'] #should be an array
  dog_json.each {|url| Gif.create(url: url)}
  array_of_gif_objects = Gif.all

  content_type :json
  array_of_gif_objects.to_json

end

delete '/favorites' do
  user_id = session[:user_id]
  delete_dog = Favorite.where(user_id: user_id, dog_id: params[:dog_id]).first
  delete_dog.destroy

end
