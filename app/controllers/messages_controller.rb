class MessagesController < ApplicationController
	

	def index
		#Message.new(:subject => 'Test_message_7', :body => 'helloooooooooooooooo', :sender_id => 1, :recipient_id => 2).save
		@messages = current_user.received_messages
		@blocked_users = current_user.blocked_users_block
		@blocked_users.each do |block|
			@banned_message = Message.where(:sender_id => block.blocked_user.id)
			@messages = @messages -@banned_message
		end

		
	end

	def sent_index
		@messages = current_user.sent_messages
	end

	def show
		@message = Message.find(params[:id])
		if @message.read_times != nil
			@message.read_times += 1
			@message.save
		else
			@message.read_times = 1
			@message.read_at = Time.now.to_datetime
			@message.save
		end

	end

	def new
		@friends = current_user.friends

			@friends.each do |friend|
				if @a
				@a += User.where(:id => friend.friend.id)
				else
				@a = User.where(:id => friend.friend.id)
				end 
			end # @a la danh sach tat ca ban be
		if @a==nil
			@a = current_user.friends
		end
		if params[:recipient_id].present?
			@recipient =  User.find(params[:recipient_id])
			@message = Message.new(subject: params[:subject], body: params[:body], recipient_id: @recipient.id)
			(session[:recipients_id] ||= []) << params[:recipient_id]
			@c = session[:recipients_id].uniq
			@recipient = []
			@name = []
			@c.each do |f|
				@q = User.find(f)
				@recipient << @q	
				@name << @q.name
			end
			@a = @a - @recipient



		else
			session.delete(:recipients_id)
			@message = Message.new(subject: params[:subject], body: params[:body])	
		end
	end

	def create
		@recipients_id = session[:recipients_id]

		@recipients_id.each do |id|	
			@message = Message.new message_params
			@message[:sender_id] = current_user.id
			@message[:recipient_id] = User.find(id).id
			@message.save
		end
			if @message.save
				flash[:success] = "Your message has been sent"
				redirect_to root_path
			else
				flash[:error] = "Please select at least one recipient"
				redirect_to :back
			end
	end

	private
	def message_params
		params.require(:message).permit(:subject, :body, :recipient_id)	
	end

end
	