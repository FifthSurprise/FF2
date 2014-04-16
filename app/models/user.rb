class User < ActiveRecord::Base
  has_many :stacks, through: :user_stacks
  has_many :user_stacks
end
