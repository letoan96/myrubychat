class MessagesController < ApplicationController
	def index
		#Message.new(:subject => 'Test_message_7', :body => 'helloooooooooooooooo', :sender_id => 1, :recipient_id => 2).save
		@messages = current_user.received_messages
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
		if params[:recipient_id].present?
			@recipient = User.find(params[:recipient_id])
			@message = Message.new(subject: params[:subject], body: params[:body] , recipient_id:  @recipient.id)
		else
			@message = Message.new(subject: params[:subject], body: params[:body])
		end
	end

	def create
		@friends = current_user.friends
		@message = Message.new message_params
		@message[:sender_id] = current_user.id
		if @message.save
			flash[:success] = "Your message has been sent"
			redirect_to root_path
		else
			render 'new'
		end
	end

	private
	def message_params
		params.require(:message).permit(:subject, :body, :sender_id , :recipient_id)	
	end

end
	