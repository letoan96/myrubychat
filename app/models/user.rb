class User < ApplicationRecord
	has_secure_password
	validates :email, presence: true, uniqueness: true
	has_many :received_messages, class_name: 'Message', foreign_key: 'recipient_id'
	has_many :sent_messages, class_name: 'Message', foreign_key: 'sender_id'
	has_many :friends, class_name: 'Friend', foreign_key: 'friend_id'
	has_many :users, class_name: 'Friend', foreign_key: 'user_id'
	def to_s
		name
	end

	def received_messages
		Message.where(recipient_id: id).order('created_at desc')
	end

	def friends
		Friend.where(user_id: id)
	end



end
