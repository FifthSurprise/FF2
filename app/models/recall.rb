class Recall < ActiveRecord::Base
  belongs_to :user
  belongs_to :card

  include SM2
  after_create  :reset_spaced_repetition_data


end
