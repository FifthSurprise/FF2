class Stack < ActiveRecord::Base
  has_many :users, through: :user_stacks
  has_many :user_stacks

  has_many :cards
  belongs_to :owner, class_name: "User"
  
  validates :name, :presence => true

  def emptycards
    #destroy all of the underlying cards
    #destroy any recalls that have those cards
    #don't need to destroy join models as it is automatic
    self.cards.each do |card|
      Recall.where("card_id = #{card.id}").each do |recall|
        recall.destroy
      end
      card.destroy
    end
  end
end
