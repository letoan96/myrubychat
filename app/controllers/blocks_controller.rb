class BlocksController < ApplicationController
	def index
		@blocked_users = current_user.blocked_users_block	
	end

	def new
		if params[:user].present?
		@blocked_user = User.find(params[:user])
		end
		@user = current_user
		if params[:confirm]=="yes"
			@add_new_blocked_user = Block.new(user_id: @user.id, blocked_user_id: @blocked_user.id)
			if @add_new_blocked_user.save
				flash[:success] = "#{@blocked_user.name} is blocked now"
				redirect_to users_path
			end
		end
		if params[:confirm]=="no"
			redirect_to users_path
		end
	end

	def destroy
		@blocked_user = Block.find(params[:id]).destroy
		redirect_to :back
	end
end
