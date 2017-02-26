class User < ApplicationRecord
	has_secure_password
	validates :email, presence: true, uniqueness: true
	has_many :received_messages, class_name: 'Message', foreign_key: 'recipient_id'
	has_many :sent_messages, class_name: 'Message', foreign_key: 'sender_id'
	has_many :friends, class_name: 'Friend', foreign_key: 'friend_id'
	has_many :users_block, class_name: 'Block', foreign_key: 'user_id'
	has_many :blocked_users_block, class_name: 'Block', foreign_key: 'blocked_user_id'
	def to_s
		name
	end

	def received_messages
		Message.where(recipient_id: id).order('created_at desc')
	end

	def friends
		Friend.where(user_id: id)
	end

	def blocked_users_block
		Block.where(user_id: id)
	end



end
