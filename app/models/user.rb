class User < ActiveRecord::Base
  has_many :stacks, through: :user_stacks
  has_many :user_stacks

  has_many :cards, through: :recalls
  has_many :recalls

  has_many :ownedstacks, :class_name => "Stack", foreign_key: "owner_id"
end
