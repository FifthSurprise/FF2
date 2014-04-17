class Card < ActiveRecord::Base
  belongs_to :stack
  has_many :recalls
  
  has_many :users, through: :recalls

end
