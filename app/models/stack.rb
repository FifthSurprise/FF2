class Stack < ActiveRecord::Base
  has_many :users, through: :user_stacks
  has_many :user_stacks

  has_many :cards
  belongs_to :owner, class_name: "User"
  
  validates :name, :presence => true
end
