class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  has_many :stacks, through: :user_stacks
  has_many :user_stacks

  has_many :cards, through: :recalls
  has_many :recalls

  has_many :ownedstacks, :class_name => "Stack", foreign_key: "owner_id"

  def study_stack(stack)
    stack.cards.each do|card|
      self.study_card(card)
    end
  end

  def study_card(card)
    recall = self.recalls.build(:card => card)
    recall.save
  end
end
