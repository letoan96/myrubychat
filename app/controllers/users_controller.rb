class UsersController < ApplicationController
	def index
		@users=User.where.not(:id => current_user.id)
		@friend=current_user.friends
		@friend.each do |friend|
			@b= User.where(:id => friend.friend.id) 
			@users = @users - @b
		end
		@blocked_users = current_user.blocked_users_block
		@blocked_users.each do |block|
			@b= User.where(:id => block.blocked_user.id) 
			@users = @users - @b
		end
	end

	def new
		@user = User.new(email: params[:email], name: params[:name])
	end

	def create
		@user = User.new user_params
		if @user.save
			session[:user_id] = @user.id
			flash[:success] = "Welcome #{@user.name}, Let's rock and roll"
			redirect_to root_path
		else
			render 'new'
		end
		
	end

	def edit
		@user=User.find(current_user.id)
		#@user.avatar_url = params[:avatar_url]
		#@user.save
	end


	private

	def user_params
		params.require(:user).permit(:name, :email, :password)	
	end
end
