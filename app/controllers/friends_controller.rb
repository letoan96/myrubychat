class FriendsController < ApplicationController
	def index
		
		@friends = current_user.friends		
	end

	def new
		@friend = User.find(params[:user])
		@user = current_user
		@add_new_friend = Friend.new(user_id: @user.id, friend_id: @friend.id) 
		if @add_new_friend.save
			flash[:success] = "#{@friend.name} is in your friend list now"
		end
	end
	
	
end
