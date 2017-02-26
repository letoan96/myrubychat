class Block < ApplicationRecord
	belongs_to :user, class_name: 'User'
	belongs_to :blocked_user, class_name: 'User'
end
