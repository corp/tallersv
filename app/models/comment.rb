class Comment < ActiveRecord::Base
  belongs_to :article
  belongs_to :user
  
  scope :recent, -> { order("created_at DESC") }
end
