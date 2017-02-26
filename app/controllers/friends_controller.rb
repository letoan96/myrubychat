class FriendsController < ApplicationController
	def index
		@friends = current_user.friends		
	end

	def new
		if params[:user].present?
		@friend = User.find(params[:user])
		end
		@user = current_user
		if params[:confirm]=="yes"
			@add_new_friend = Friend.new(user_id: @user.id, friend_id: @friend.id)
			if @add_new_friend.save
				flash[:success] = "#{@friend.name} is in your friend list now"
				redirect_to users_path
			end
		end
		if params[:confirm]=="no"
			redirect_to users_path
		end
	end

	def destroy
		@friend = Friend.find(params[:id]).destroy
		redirect_to :back
	end
	
	
end
