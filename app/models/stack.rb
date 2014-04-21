class Stack < ActiveRecord::Base
  has_many :users, through: :user_stacks
  has_many :user_stacks

  has_many :cards
  belongs_to :owner, class_name: "User"
  
  validates :name, :presence => true

  def emptycards
    self.cards.each do |card|
      Recall.where("card_id = #{card.id}").each do |recall|
        recall.destroy
      end
      card.destroy
    end
  end
end
