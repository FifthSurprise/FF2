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

  #get all recalls that pertain to a user
  def get_recalls(user)
    #join the Recall table with the stack table through card_id
    # Recall.where("user_id = #{@user.id} and ")
  end
end
