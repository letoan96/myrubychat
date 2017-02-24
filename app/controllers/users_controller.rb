class UsersController < ApplicationController
	def index
		@users=User.where.not(id: current_user.id)
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

	private

	def user_params
		params.require(:user).permit(:name, :email, :password)	
	end
end
