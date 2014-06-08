class Comment < ActiveRecord::Base
  belongs_to :article
  
  scope :recent, -> { order("created_at DESC") }
end
